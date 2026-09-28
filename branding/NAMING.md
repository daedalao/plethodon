# SiskiyouPlethodon - naming convention

Independent build of the Gecko engine for PowerPC (32-bit G4, 64-bit BE,
ppc64le), built from Mozilla Firefox source code. Not affiliated with or
endorsed by Mozilla. Mozilla does not allow the Firefox name or logo on
unofficial builds, so nothing user-facing says Firefox except the factual
attribution line in the About dialog.

**Name:** the Siskiyou Mountains salamander, *Plethodon stormi*, which lives
only in the Siskiyou Mountains (Applegate drainage, Seiad Valley) - the forest
the 2002 Biscuit Fire burned (Oregon's largest recorded forest fire, 499,965
acres, Kalmiopsis Wilderness). The salamander is also the creature old stories
say lives in fire. Checked 2026-09-26: "SiskiyouPlethodon" has no matches
anywhere; "Plethodon" alone is the salamander genus and names no software.

| Where | Name | Rule |
|---|---|---|
| Full name | SiskiyouPlethodon | One word, camel case (capital S and P), never with a space. About dialog, desktop entry name, website, announcements |
| Short name | Plethodon | Where Firefox says "Firefox": menus, window titles, taskbar, "Quit Plethodon", "Plethodon Settings" |
| Machine name | `plethodon` | pacman package, `/usr/bin/plethodon`, `/usr/lib/plethodon/`, `MOZ_APP_NAME` |
| Window identity | `plethodon` | remoting name, Wayland app_id, X11 WM_CLASS; `plethodon.desktop` |
| Profile | `~/.plethodon/` | separate from any Firefox profile |
| Branding dir | `browser/branding/plethodon/` | `--with-branding=browser/branding/plethodon` instead of `--enable-official-branding`; brand-full-name and brand-product-name "SiskiyouPlethodon", brand-short-name "Plethodon" |
| About dialog | SiskiyouPlethodon 154.0.1 (ppc) | 2nd line: "Built from Mozilla Firefox 154.0.1 source code for Arch POWER (powerpc). Not affiliated with or endorsed by Mozilla." |
| Version | 154.0.1 | = Gecko version; our rebuilds bump pkgrel (154.0.1-4) |
| Architectures | (ppc) (ppc64) (ppc64le) | one product name; arch only in About and package filename |
| Dev channel | Plethodon Ember | `plethodon-ember` everywhere, installs beside stable |
| User agent | unchanged | Gecko UA incl. `Firefox/154.0` compat token |
| Git tags | `v154.0.1-4` | codename in the tag message |

## Release codenames

One Oregon wildfire per Gecko major, by year of the fire, alphabetical within
a year. Release notes and tag messages only, never in the UI. (The Biscuit
Fire belongs to the product's story, so it is not in the list.)

154 Tillamook (1933) - 155 Bandon (1936) - 156 B&B Complex (2003) -
157 Chetco Bar (2017) - 158 Eagle Creek (2017) - 159 Archie Creek (2020) -
160 Beachie Creek (2020) - 161 Holiday Farm (2020) - 162 Lionshead (2020) -
163 Riverside (2020) - 164 Bootleg (2021) - 165 Cedar Creek (2022)

## Logo

- `plethodon.svg`: primary mark, 32 px and up (ember badge, umber
  salamander with brass flecks, talus stones).
- `plethodon-small.svg`: 16-24 px (heavier body, no detail).
- `plethodon-symbolic.svg`: one colour, `currentColor`.
- `png/defaultNN.png`: 16, 22, 24 (small mark), 32, 48, 64, 128, 256, 512.
- Wordmark: Rokkitt, "Siskiyou" Medium + "Plethodon" ExtraBold, one word, no
  space. Short-name lockup: "Plethodon" alone.
- Never: a fox, a globe, a creature wrapped around a circle, an
  orange-to-purple gradient, a red/orange salamander, the Firefox name or logo
  in the product name, icons, window titles or desktop entry.

Palette: Biscuit Ember #D9531F, Talus Char #1B1714, Salamander Umber #2A1C16,
Brass Fleck #E8C77A, Kalmiopsis #B0356E, Serpentine Ash #E9EBE6.
