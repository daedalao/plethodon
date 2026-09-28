# SiskiyouPlethodon

A web browser for 32-bit PowerPC Macs (G4) running [Arch POWER](https://archlinuxpower.org/).
It is built from Mozilla Firefox 154.0.1 source code and adds:

- a ppc32 JavaScript JIT (Baseline + Ion), about 15x faster than the interpreter
- big-endian fixes for canvas, image encoding, Skia and software WebRender
- OpenGL compositing of software-rendered tiles on X11 (Radeon 9600/9700 with Mesa r300)
- AltiVec paths in SWGL

**SiskiyouPlethodon is not Firefox.** It is not affiliated with or endorsed by
Mozilla. Firefox is a trademark of the Mozilla Foundation, and the Firefox name
and logo are not used in this browser. Mozilla services (Firefox Relay, Firefox
Monitor, Mozilla accounts, add-ons.mozilla.org) keep their own names.

The name comes from the Siskiyou Mountains salamander, *Plethodon stormi*. See
[branding/NAMING.md](branding/NAMING.md).

## Install (G4, Arch POWER `powerpc`)

Download `plethodon-154.0.1-1-powerpc.pkg.tar.zst` from
[Releases](https://github.com/daedalao/plethodon/releases), then run:

```sh
sudo pacman -U plethodon-154.0.1-1-powerpc.pkg.tar.zst
plethodon
```

The browser installs to `/usr/lib/plethodon`, and its menu entry is called
**SiskiyouPlethodon**. It can be installed alongside a `firefox` package and
keeps its own profile (`~/.plethodon`), so it never reads or changes a Firefox
profile.

It needs a G4 because the build uses AltiVec (`-mcpu=g4`), so G3s are not
supported. It was tested on a PowerBook G4 15" (DLSD, 1.67 GHz 7447A, 2 GB RAM,
Mobility Radeon 9600/9700) with Arch POWER's `mesa 1:26.1.2`.

### Defaults for a G4

The package sets these defaults in `/usr/lib/plethodon/browser/defaults/preferences/vendor.js`.
You can override any of them in `about:config`:

| Pref | Value | Why |
|---|---|---|
| `gfx.webrender.software` | `true` | The RV350 can't run hardware WebRender |
| `gfx.webrender.software.opengl` | `true` | The GPU composites the software-rendered tiles. **If the window stays black, set this to `false`** |
| `layout.frame_rate` | `20` | Less redraw work |
| `general.smoothScroll` | `false` | Scrolling feels more responsive |
| `fission.autostart` | `false` | Fewer content processes for 2 GB of RAM |
| `dom.ipc.processCount` | `2` | Same |

Telemetry uploads and the first-run pages are turned off.

If the window is black, start `plethodon --safe-mode` (troubleshoot mode
turns off hardware acceleration). Then set `gfx.webrender.software.opengl` to
`false` in `about:config` and restart.

### Known issues

- Rendering lags behind input on a single-core G4. Pages you scroll through
  are fine; heavy web apps are slow.
- A 1x1 canvas `getImageData` can very rarely return a wrong pixel.
- Headless screenshots of canvas content have the wrong colours.

## Build from source

Building on the G4 itself isn't practical: it has only 2 GB of RAM and would take
days. The PKGBUILD cross-builds on an Arch POWER **ppc64le** host (POWER8/9):

```sh
./setup-xroot.sh                     # ppc32 sysroot + toolchain wrappers in ./xroot
FF_XROOT=$PWD/xroot CARCH=powerpc makepkg -d --skippgpcheck
```

If `FF_XROOT` isn't set, it configures a native build the way Arch POWER does.
A full build takes about an hour on a POWER8.

`release/PKGBUILD` instead repackages the tarball from `./mach package`
(`plethodon-154.0.1.en-US.linux-powerpc.tar.xz`) into the release package.

### Patches, applied in order

| Patches | From |
|---|---|
| `0001-Install-under-remoting-name`, `0002-Bug-2053518…`, `hotfix-*`, `sandbox-*`, `0001`–`0008` VSX/JIT/BE rendering, `xlib-success`, `hotfix-ppc-not-power8.diff` | Arch POWER's firefox recipe |
| `0009`, `0010` | archbe (ppc64 big-endian) |
| `ppc32-0001`–`ppc32-0019` | this project: ppc32 build fixes, big-endian fixes, the ppc32 JIT backend (`js/src/jit/ppc/`), the X11 compositing fix, SWGL AltiVec |
| `ppc32-0020` + `plethodon-branding.tar.gz` | SiskiyouPlethodon branding (`browser/branding/plethodon`), the `~/.plethodon` profile, Firefox-named UI strings replaced |

The build uses `--with-branding=browser/branding/plethodon --with-app-name=plethodon`,
never `--enable-official-branding`. The internal app basename stays `Firefox`
so the User-Agent (`… Firefox/154.0`) and add-on compatibility checks keep
working.

## License

The patches and build scripts are under the [Mozilla Public License 2.0](https://mozilla.org/MPL/2.0/),
the same license as the Firefox source they modify. The Rokkitt font in the
wordmark is under the SIL Open Font License 1.1.
