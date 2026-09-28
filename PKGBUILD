# SiskiyouPlethodon for Arch POWER powerpc (32-bit big-endian, PowerBook G4).
# Built from Mozilla Firefox source code; not affiliated with or endorsed by
# Mozilla. Unofficial branding only (browser/branding/plethodon): Mozilla
# does not allow the Firefox name or logo on builds like this one.
# Based on Arch POWER's firefox PKGBUILD.
#
# Patch set:
#   - Arch POWER's set (hotfix-*, sandbox-*, 0001-0008, xlib-success,
#     hotfix-ppc-not-power8.diff) and archbe 0009/0010
#   - ppc32-0001..0019: our work, one patch per commit of src/ branch ppc32-jit
#     (ppc32 build fixes, big-endian rendering fixes, ppc32 Baseline+Ion JIT,
#     X11 GPU compositing fix, SWGL AltiVec)
#   - ppc32-0020 + plethodon-branding.tar.gz: SiskiyouPlethodon branding
#
# Building natively on a G4 is not practical (2 GB RAM, days). Cross build on
# an Arch POWER ppc64le host (POWER8/9): ./setup-xroot.sh creates the ppc32
# sysroot + toolchain wrappers in ./xroot, then
#   FF_XROOT=$PWD/xroot CARCH=powerpc makepkg -d --skippgpcheck
# Without FF_XROOT it configures a native build the way Arch POWER does.

pkgname=plethodon
pkgver=154.0.1
pkgrel=1
pkgdesc="Web browser for PowerPC G4, built from Mozilla Firefox source code (ppc32 JIT)"
url="https://github.com/daedalao/plethodon"
arch=(powerpc)
license=(MPL-2.0)
depends=(
  alsa-lib at-spi2-core bash cairo dbus ffmpeg fontconfig freetype2
  gdk-pixbuf2 glib2 glibc gtk3 hicolor-icon-theme icu libffi libgcc
  libjpeg-turbo libjxl libpulse libstdc++ libx11 libxcb libxcomposite
  libxdamage libxext libxfixes libxrandr libxss libxt mime-types nspr
  pango pixman ttf-font zlib
)
makedepends=(
  cbindgen clang diffutils imake lld llvm mesa nasm nodejs python rust
  unzip yasm zip
)
optdepends=(
  'hunspell-en_US: Spell checking, American English'
  'libnotify: Notification integration'
  'xdg-desktop-portal: Screensharing with Wayland'
)
options=(!debug !emptydirs !lto !makeflags strip)
source=(
  https://archive.mozilla.org/pub/firefox/releases/$pkgver/source/firefox-$pkgver.source.tar.xz{,.asc}
  $pkgname-symbolic.svg
  $pkgname.desktop
  org.archpower.$pkgname.metainfo.xml
  plethodon-branding.tar.gz

  # Arch POWER, applied in this order
  0001-Install-under-remoting-name.patch
  0002-Bug-2053518-Handle-the-oe-linux-rust-targets-added-i.patch
  hotfix-32bit.patch
  hotfix-bigendian-no-fading.patch
  hotfix-gcc14.patch
  hotfix-glibc-2.43.patch
  hotfix-ppc.patch
  hotfix-be-image-formats.patch
  sandbox-fonts.patch
  sandbox-x11.patch
  0001-Add-PPC64LE-VSX-instructions-for-SKIA.patch
  0002-Add-PPC64LE-VSX-instructions-for-libwebp.patch
  0003-Add-PPC64BE-VSX-instructions-for-libwebp.patch
  0004-Add-PPC64LE-JIT-backend.patch
  0005-Add-PPC64BE-JIT-backend.patch
  0006-Enable-hardware-GHASH-on-big-endian-PPC64-in-NSS-fre.patch
  0007-Add-big-endian-rendering-support-for-Skia-and-softwa.patch
  0008-Add-PPC64-Linux-support-to-the-Gecko-profiler.patch
  # archbe
  0009-SWGL-big-endian-swizzle-only-for-X11.patch
  0010-PPC64-JIT-fix-xsmaxdp-xsmindp-encodings.patch
  xlib-success.patch
  hotfix-ppc-not-power8.diff

  # ppc32 / PowerBook G4
  ppc32-0001-ppc32-MOZ_CrashSequence-stw-xptcall-asm-for-clang-IA.patch
  ppc32-0002-glean-core-mutex-AtomicU64-fallback-without-64-bit-a.patch
  ppc32-0003-mozinference-link-libatomic.patch
  ppc32-0004-ppc32-fix-jsval-handle-passing-in-xptcinvoke-enable-.patch
  ppc32-0005-image-encoders-read-HOSTARGB-pixels-little-endian-bi.patch
  ppc32-0006-Skia-big-endian-SkRasterPipeline-8888-load-store-dro.patch
  ppc32-0007-ppc32-JIT-JS_CODEGEN_PPC-plumbing-Architecture-and-A.patch
  ppc32-0008-Big-endian-32-bit-fixes-TypedArray-inline-data-point.patch
  ppc32-0009-ppc32-JIT-backend-MacroAssembler-trampolines-Ion-cod.patch
  ppc32-0010-ppc32-pass-class-type-arguments-by-reference-at-the-.patch
  ppc32-0011-jsapi-tests-big-endian-and-ppc32-support-in-testJitA.patch
  ppc32-0012-32-bit-big-endian-fixes-RawInt32-stub-fields-inline-.patch
  ppc32-0013-NUNBOX32-big-endian-payload-address-for-raw-pointer-.patch
  ppc32-0014-ppc32-restore-LR-on-the-VM-path-of-the-concat-string.patch
  ppc32-0015-ppc32-jump-table-entries-are-RawPointer-CodeLabels.patch
  ppc32-0016-Big-endian-NUNBOX32-fixes-BigInt64-digit-order-priva.patch
  ppc32-0017-ppc32-DataView-data-pointer-is-the-payload-of-the-da.patch
  ppc32-0018-gtk-no-native-layer-root-on-X11-fixes-SW-WebRender-O.patch
  ppc32-0019-swgl-AltiVec-paths-for-math-helpers-and-packs-vector.patch
  # SiskiyouPlethodon
  ppc32-0020-SiskiyouPlethodon-profile-dir-and-UI-strings.patch
)
validpgpkeys=(
  # Mozilla Software Releases <release@mozilla.com>
  14F26682D0916CDD81E37B6D61B7B526D98F0353
)

sha256sums=('9cbe191fc74b46108376b1d9bf607c0a40288074e0f2333671253789d6ebbd15'
            'SKIP'
            '6a019008ca1469290f6cb5f38bb5f85ba051a8d00075eacf21e629461deb4938'
            '581464e21f2ead91fbd4f0576b4961209ad2ee20f2fbb01cf0a3ade81885a274'
            '07f3c57eef9103e59d37b442d84ce3ab05a5a0623f9b6855a001add58f0a70ec'
            '01f73c7b712d0c2866740ae9efa667652d7ef858563ede5f22be780d0ff8ffb4'
            '83311ecf83698f2739ac42f26777df2e5df3fc090144480d10a9c203076b8165'
            '502f5419871b92cf222cac658aa4d0709f7c04701deaeeda9b7238cc7bc845dc'
            '6e7ed5f86d081e979713542594fb4b01b0a4f6ac9fdd84ed479dc88aa3bd0a2f'
            '27d19a870bb62bef886732e19ccf6c905497e78c6c5741e91d73125061b95b78'
            '57c58477a455bcb5ccff387d205321b7a9ff58ec25ae365e330993b428ba1a6a'
            'af135adc5e982aede73f33ea19d4580cbfbe4f0d99f74ff2e01f86049dd00761'
            'f37696386eac29a7896c0a1903bc289fa6d5bceae191ecc70b49e7f6e32a41f8'
            'bbe60b24ea603da456c37e3476ca2c39cd5d90043822dd64921add3c6c7257fd'
            'e8a6346e088d261e9c149667223f1612f664ce5f4a30f4bbe068115b72e59c38'
            'bfce3e17dc39c536b0bd2a6be1a90985bf54d7fdf8c4141ba5410183ab894f9c'
            'f3043b74b27f27067f1429216c83a55de8764946b508e0e6efc31c787acb97e7'
            'a29581d7098aa66478dd54116407fe459a64fc71cbd617eb76f3a853e169e4e1'
            'e4b158dfcfc79432cc1f756f952b9b458e118ee00c97728cadd99da8452b85ef'
            '79c0e0c5e40467dc0c412d58414dd6d5c506ac5fa36308bc3950522d0e24dcd7'
            '563cd8f91309efb9a21a15169b23bff90dd7f46c7009de199b3704748e158e49'
            'bd1d14661918fc69a643496e495932c4e1352b07210a78af398ae2d169d68f9d'
            '5c67b2b7a12ac47f2413b03b3bd5fb074a9257ef3badb0897a4dc45e2ab59bc6'
            'e4ba6fa61feda850111ac5c62f912077edb8445da490549029bd7e2e9384a32f'
            'c6182788f9bc4c8088a3aee6bab71754dd82a74709c261d7dbb41cea832c0188'
            '9d5380d30c8edab71ba63c783ad54cfa187a67fc7d33d2a3f9cf55690ca5c143'
            '36e7e445968a22fefea96f851003343632dea489a02ee01394d9283515f65465'
            '2904bc0b11a2b703cb9f952d5760c5b8fbe9c07793d622c05402359e059a61ec'
            '9f33b2567b12b73fd487b90f9bdade6050fde479b4db31085c6d70c43fb17497'
            'd55bafb3392e432a312415af1d954461956c1ef31b3020ee3102f07d43c90112'
            'd8e6525fb76c58dd92c2af880aa9ea962b488232ef0f0a99d46fdd39edfa877c'
            '198032d387830d9d3eb4d3ffb12ae81a3b29e76026033ab0ae9b94fa35dc09b5'
            'fe40f35ae70fb591f2a2c7c82296f87c4fe9037fc097e52f6db0b13970b95e07'
            '344bd64f3046d1a20d2d459112994d99adde566ba9c1dd6328fddbcf1614a991'
            '11021c6ea21c1bf0fe18260e6347e59432094793100d045ad74257dc7d45dace'
            '546cadafcf98c3d2361783965fddfbb6ddde34d7dff2b272d91ebeefd32d0509'
            'e230c699ae8d53edcbe9f7f58ce199b9b3b23146373f95dc480bde13c66490c6'
            'aa08530a8faeac5bd07a29850448712fc33d18651500f814418ada4040c92f2e'
            'a326135d1de92fbae9d9d9b460ab3fba73bcb25ef6853669b5f787d788793ae0'
            '924a145a627d9f0844abd798d12c98cfb6e9ae0bec7f7ff9eccbaf3d19c6099f'
            'ce76f6ded6db90a86bbcaf9e2a57028db83cb293c976f055ae0cfe5d3d1166a1'
            '1bf7eaf8137d2eae490aa888ff00d9c753479c3b4ef553ba789b924411414b7a'
            '955677aef15fe0fd89cae23b87f396baa95cced207f2480588a5bcb509a57842'
            'c90e27613a2e2343cb80a0c9e5f7ef19abd2060ee2268793991ce40523613636'
            '1a4b0a185bf8df738e86d9b4acd2a28ecb36c4ac081085f08b8b3c5fdd563979'
            'e40427bc43eca9b3a734fdfbf687257fc7807d095d1e00f6a6bee468834ad5f4'
            'ac4b612b5b26bcc9948a691ef160289050ec7aff33e190e8ce58041cb3c6f0a9'
            '6cb98b67e49d746050cebdc4f1fcbff791148d1f24f1e6f40ce0dad0f1b04a95')

prepare() {
  mkdir -p mozbuild
  cd firefox-$pkgver

  local src
  for src in "${source[@]}"; do
    src="${src%%::*}"
    src="${src##*/}"
    [[ $src = *.patch || $src = *.diff ]] || continue
    echo "Applying patch $src..."
    patch -Np1 -i "../$src"
  done

  cp -r ../plethodon-branding browser/branding/plethodon

  cat >../mozconfig <<END
ac_add_options --enable-application=browser
mk_add_options MOZ_OBJDIR=${PWD@Q}/obj

ac_add_options --prefix=/usr
ac_add_options --enable-release
ac_add_options --enable-optimize="-O2 -mcpu=g4"
ac_add_options --enable-linker=bfd
ac_add_options --disable-install-strip
ac_add_options --disable-bootstrap
ac_add_options --disable-debug-symbols

# Branding: SiskiyouPlethodon, never official Firefox branding. The app
# basename stays "Firefox" internally (UA compat token, add-on checks).
ac_add_options --with-branding=browser/branding/plethodon
ac_add_options --with-app-name=$pkgname
ac_add_options --enable-update-channel=release
ac_add_options --with-distribution-id=org.archpower
ac_add_options --with-unsigned-addon-scopes=app,system
ac_add_options --allow-addon-sideload
export MOZ_APP_REMOTINGNAME=$pkgname

# System libraries (system nss 3.126 < required 3.126.1: bundled)
ac_add_options --with-system-nspr
ac_add_options --with-system-zlib
ac_add_options --with-system-pixman
ac_add_options --with-system-ffi
ac_add_options --with-system-jpeg
ac_add_options --with-system-icu
ac_add_options --without-system-png

# Features
ac_add_options --enable-alsa
ac_add_options --disable-jack
ac_add_options --disable-updater
ac_add_options --disable-tests
ac_add_options --disable-crashreporter
ac_add_options --disable-jemalloc
ac_add_options --disable-dbus
ac_add_options --disable-necko-wifi
ac_add_options --enable-jxl
ac_add_options --without-wasm-sandboxed-libraries
END

  if [[ -n $FF_XROOT ]]; then
    cat >>../mozconfig <<END

# Cross build from ppc64le (op64k)
ac_add_options --target=powerpc-unknown-linux-gnu
ac_add_options --with-sysroot=$FF_XROOT/sysroot
export CC=clang CXX=clang++ HOST_CC=clang HOST_CXX=clang++
export PKG_CONFIG=$FF_XROOT/toolchain/bin/powerpc-linux-gnu-pkg-config
export RUSTC=$FF_XROOT/toolchain/rust/bin/rustc RUSTDOC=$FF_XROOT/toolchain/rust/bin/rustdoc CARGO=/usr/bin/cargo
export NODEJS=$FF_XROOT/toolchain/node/bin/node
export LDFLAGS="-Wl,-rpath-link,$FF_XROOT/sysroot/usr/lib"
END
  fi

  # Vendored crates are patched (portable-atomic, glean-core, wgpu)
  sed -i 's/\("files":{[^,]*\),[^}]*}/\1}/' third_party/rust/*/.cargo-checksum.json
}

build() {
  cd firefox-$pkgver

  export MACH_BUILD_PYTHON_NATIVE_PACKAGE_SOURCE=pip
  export MOZBUILD_STATE_PATH="$srcdir/mozbuild"
  export MOZ_BUILD_DATE="$(date -u${SOURCE_DATE_EPOCH:+d @$SOURCE_DATE_EPOCH} +%Y%m%d%H%M%S)"
  export MOZ_NOSPAM=1
  export MOZ_MAKE_FLAGS="${MAKEFLAGS}"

  if [[ -n $FF_XROOT ]]; then
    # The build host's makepkg.conf flags are for ppc64le
    unset CFLAGS CXXFLAGS LDFLAGS RUSTFLAGS
    export PATH="$FF_XROOT/toolchain/node/bin:$FF_XROOT/toolchain/rust/bin:$FF_XROOT/toolchain/bin:$PATH"
  else
    CFLAGS="${CFLAGS/_FORTIFY_SOURCE=?/_FORTIFY_SOURCE=2}"
    CXXFLAGS="${CXXFLAGS/_FORTIFY_SOURCE=?/_FORTIFY_SOURCE=2}"
    CFLAGS="${CFLAGS/-fexceptions/}"
    CXXFLAGS="${CXXFLAGS/-fexceptions/}"
    CFLAGS="${CFLAGS/-Werror=format-security/}"
    CXXFLAGS="${CXXFLAGS/-Werror=format-security/}"
  fi

  ulimit -n 4096
  cp ../mozconfig .mozconfig
  ./mach build --priority normal
}

package() {
  cd firefox-$pkgver
  DESTDIR="$pkgdir" ./mach install
  local appdir="$pkgdir/usr/lib/$pkgname"

  install -Dvm644 /dev/stdin "$appdir/browser/defaults/preferences/vendor.js" <<END
// Use LANG environment variable to choose locale
pref("intl.locale.requested", "");

// Use system-provided dictionaries
pref("spellchecker.dictionary_path", "/usr/share/hunspell");

// Disable default browser checking.
pref("browser.shell.checkDefaultBrowser", false);

// Don't disable extensions in the application directory
pref("extensions.autoDisableScopes", 11);

// Big-endian: only software WebRender converts pixels for the display
// (0007-Add-big-endian-rendering-support...). The RV350 cannot run
// hardware WebRender; composite the software-rendered tiles with OpenGL
// (ppc32-0018 makes this work on X11). Set it to false if the window stays
// black on your GPU/Mesa.
pref("gfx.webrender.software", true);
pref("gfx.webrender.software.opengl", true);
// PowerBook G4 settings that felt best in testing.
pref("layout.frame_rate", 20);
pref("general.smoothScroll", false);

// PowerBook G4: 1 core, 2 GB RAM.
pref("dom.ipc.processCount", 2);
pref("dom.ipc.processPrelaunch.enabled", false);
pref("browser.tabs.unloadOnLowMemory", true);
pref("browser.sessionhistory.max_total_viewers", 0);
pref("browser.sessionstore.interval", 60000);
pref("media.hardware-video-decoding.enabled", false);
pref("gfx.canvas.accelerated", false);
pref("layers.acceleration.disabled", true);
pref("browser.startup.preXulSkeletonUI", false);
pref("toolkit.cosmeticAnimations.enabled", false);
pref("extensions.pocket.enabled", false);
pref("browser.ml.enable", false);
// One content process per site (Fission) means 4+ processes for two tabs;
// too much for 2 GB.
pref("fission.autostart", false);
pref("fission.webContentIsolationStrategy", 0);
// No first-run privacy notice tab / telemetry uploads.
pref("datareporting.policy.dataSubmissionPolicyBypassNotification", true);
pref("toolkit.telemetry.reportingpolicy.firstRun", false);
pref("datareporting.healthreport.uploadEnabled", false);
pref("browser.aboutwelcome.enabled", false);
END

  install -Dvm644 /dev/stdin "$appdir/distribution/distribution.ini" <<END
[Global]
id=archlinux
version=1.0
about=SiskiyouPlethodon for Arch POWER (powerpc)

[Preferences]
app.distributor=archlinux
app.distributor.channel=$pkgname
app.partner.archlinux=archpower
END

  local i theme=plethodon
  for i in 16 22 24 32 48 64 128 256 512; do
    install -Dvm644 browser/branding/$theme/default$i.png \
      "$pkgdir/usr/share/icons/hicolor/${i}x${i}/apps/$pkgname.png"
  done
  install -Dvm644 browser/branding/$theme/content/about-logo.png \
    "$pkgdir/usr/share/icons/hicolor/192x192/apps/$pkgname.png"
  install -Dvm644 browser/branding/$theme/content/about-logo@2x.png \
    "$pkgdir/usr/share/icons/hicolor/384x384/apps/$pkgname.png"
  install -Dvm644 browser/branding/$theme/content/about-logo.svg \
    "$pkgdir/usr/share/icons/hicolor/scalable/apps/$pkgname.svg"

  install -Dvm644 ../$pkgname-symbolic.svg -t "$pkgdir/usr/share/icons/hicolor/symbolic/apps"
  install -Dvm644 ../$pkgname.desktop -t "$pkgdir/usr/share/applications"
  install -Dvm644 ../org.archpower.$pkgname.metainfo.xml -t "$pkgdir/usr/share/metainfo"

  install -Dvm755 /dev/stdin "$pkgdir/usr/bin/$pkgname" <<END
#!/bin/sh
exec /usr/lib/$pkgname/$pkgname "\$@"
END
  ln -srfv "$pkgdir/usr/bin/$pkgname" "$appdir/$pkgname-bin"

  # Use system certificates
  if [[ -e $appdir/libnss3.so ]]; then
    ln -sfv ../libnssckbi.so -t "$appdir"
  fi
}

# vim:set sw=2 sts=-1 et:
