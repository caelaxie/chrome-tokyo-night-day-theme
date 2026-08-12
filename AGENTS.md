# AGENTS.md

## What this repo is

A Chrome theme: the **TokyoNight Day** color scheme applied to the Chrome UI.

## Structure

- `manifest.json` — the entire theme. Manifest V3 with a single `theme.colors` section; there is no code, build step, or dependency.
- `tokyonight-day.itermcolors` — the canonical palette, vendored from [iTerm2-Color-Schemes](https://github.com/mbadolato/iTerm2-Color-Schemes/blob/master/schemes/TokyoNight%20Day.itermcolors). Treat it as read-only; update it only by re-fetching upstream.

## Color rules (MUST follow)

- Every color in `manifest.json` MUST come from `tokyonight-day.itermcolors`. Never invent shades.
- Colors in `manifest.json` are `[r, g, b]` integer arrays, not hex.
- To extract values from the plist:
  ```sh
  python3 -c "
  import plistlib
  p = plistlib.load(open('tokyonight-day.itermcolors','rb'))
  for k,v in p.items():
      if isinstance(v, dict) and 'Red Component' in v:
          print(k, [round(v[c]*255) for c in ('Red Component','Green Component','Blue Component')])"
  ```

## Current mapping

| itermcolors key | Hex | RGB | Chrome `theme.colors` key |
|---|---|---|---|
| Background Color | `#e1e2e7` | `[225, 226, 231]` | `toolbar`, `ntp_background`, `omnibox_background` |
| Foreground Color | `#3760bf` | `[55, 96, 191]` | `tab_text`, `bookmark_text`, `ntp_text`, `ntp_header`, `omnibox_text` |
| Selection Color | `#99a7df` | `[153, 167, 223]` | `frame` |
| Ansi 8 Color (bright black) | `#a1a6c5` | `[161, 166, 197]` | `frame_inactive`, `frame_incognito_inactive`, `button_background` |
| Ansi 7 Color (white) | `#6172b0` | `[97, 114, 176]` | `tab_background_text`, `toolbar_button_icon`, `frame_incognito` |
| Ansi 4 Color (blue) | `#2e7de9` | `[46, 125, 233]` | `ntp_link` |

Deviation note: the file's `Link Color` (`#73daca`) is intentionally NOT used for `ntp_link` — its contrast against `#e1e2e7` is too low. `Ansi 4` blue is used instead.

When adding or changing a Chrome color key, extend the table above with the itermcolors key it maps from.

Chrome theme color keys: https://developer.chrome.com/docs/extensions/develop/ui/themes

## Test / verify

1. Validate JSON: `python3 -c "import json; json.load(open('manifest.json'))"`
2. Visual check: open `chrome://extensions`, enable **Developer mode**, **Load unpacked**, select this folder. Then inspect the frame, active/inactive tabs, omnibox, and new-tab page.

## Do not

- Do not add a build step, bundler, or npm tooling — the manifest is the deliverable.
- Do not add theme images unless explicitly requested; colors only.
- Do not bump `version` except when publishing.
