#!/bin/bash
# Build the FF_XROOT cross environment for this PKGBUILD on an Arch POWER
# ppc64le host (POWER8/9, e.g. S822LC). No root needed and nothing is
# installed on the host: the ppc32 sysroot comes from Arch POWER's powerpc
# repo via `fakeroot pacman -r`.
#
#   ./setup-xroot.sh [dir]        (default: ./xroot)
#   FF_XROOT=$PWD/xroot CARCH=powerpc makepkg -d --skippgpcheck
#
# Host packages needed: base-devel clang lld llvm rust cbindgen nasm python
# unzip zip curl. The host's rust must be the same version as the powerpc
# repo's rust (the powerpc std is used with the host's rustc).
set -euo pipefail

X=$(realpath -m "${1:-xroot}")
REPO=${REPO:-https://repo.archlinuxpower.org}
NODE=${NODE:-v20.20.2}   # Node 26 breaks Firefox's bundled Babel
HOST=$(rustc -vV | sed -n 's/^host: //p')
PKGS=(
  filesystem glibc linux-api-headers gcc gcc-libs rust
  alsa-lib at-spi2-core cairo dbus ffmpeg fontconfig freetype2 gdk-pixbuf2
  glib2 gtk3 icu libffi libjpeg-turbo libjxl libpulse libx11 libxcb
  libxcomposite libxdamage libxext libxfixes libxkbcommon libxrandr libxss
  libxt mesa libglvnd libdrm nspr pango pixman zlib
)

mkdir -p "$X"/{sysroot,pacman/db,pacman/cache,toolchain/bin,toolchain/rust/bin,toolchain/rust/lib/rustlib}
cd "$X"

echo "== ppc32 sysroot from $REPO"
# The host's Arch POWER keyring (same keys sign the powerpc repo); the private
# key dir is root-only, hence sudo.
if [ ! -d pacman/gnupg ]; then
  sudo cp -r /etc/pacman.d/gnupg pacman/gnupg
  sudo chown -R "$(id -u):$(id -g)" pacman/gnupg
fi
cat > pacman/pacman.conf <<END
[options]
Architecture = powerpc
SigLevel = Required DatabaseOptional
LocalFileSigLevel = Optional
GPGDir = $X/pacman/gnupg
DBPath = $X/pacman/db
CacheDir = $X/pacman/cache
HookDir = $X/pacman/nohooks
NoExtract = usr/share/doc/* usr/share/man/* usr/share/info/* usr/share/locale/* usr/share/help/*

[base-any]
Server = $REPO/base/any
[base]
Server = $REPO/base/\$arch
END
mkdir -p pacman/nohooks
fakeroot pacman --config pacman/pacman.conf -r "$X/sysroot" -Sy --needed \
  --noconfirm --noscriptlet --disable-download-timeout "${PKGS[@]}"
# Scriptlets and hooks can't run for a foreign arch; nothing in here needs them.

echo "== rust private sysroot (host $HOST + powerpc-unknown-linux-gnu)"
want=$(pacman --config pacman/pacman.conf -r "$X/sysroot" -Q rust | cut -d' ' -f2)
have=$(pacman -Q rust | cut -d' ' -f2)
[ "$want" = "$have" ] || { echo "host rust $have != powerpc rust $want; they must match"; exit 1; }
R=toolchain/rust/lib/rustlib
rm -rf "$R"/{"$HOST",powerpc-unknown-linux-gnu,etc,src}
cp -a /usr/lib/rustlib/"$HOST" /usr/lib/rustlib/etc "$R"/
[ -d /usr/lib/rustlib/src ] && cp -a /usr/lib/rustlib/src "$R"/
cp -a sysroot/usr/lib/rustlib/powerpc-unknown-linux-gnu "$R"/
for t in rustc rustdoc; do
  printf '#!/bin/sh\nexec /usr/bin/%s --sysroot %s "$@"\n' $t "$X/toolchain/rust" > toolchain/rust/bin/$t
done

echo "== pkg-config wrapper"
cat > toolchain/bin/powerpc-linux-gnu-pkg-config <<END
#!/bin/sh
export PKG_CONFIG_SYSROOT_DIR=$X/sysroot
export PKG_CONFIG_LIBDIR=$X/sysroot/usr/lib/pkgconfig:$X/sysroot/usr/share/pkgconfig
unset PKG_CONFIG_PATH
exec /usr/bin/pkg-config "\$@"
END
chmod +x toolchain/bin/* toolchain/rust/bin/*

echo "== node $NODE"
if [ ! -x toolchain/node/bin/node ]; then
  curl -fL https://nodejs.org/dist/$NODE/node-$NODE-linux-ppc64le.tar.xz | tar xJ -C toolchain
  ln -sfn node-$NODE-linux-ppc64le toolchain/node
fi

echo "done: FF_XROOT=$X CARCH=powerpc makepkg -d --skippgpcheck"
