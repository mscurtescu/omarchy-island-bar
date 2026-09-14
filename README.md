# Island Bar

[![Omarchy Quattro](https://img.shields.io/badge/Omarchy-Quattro-111111)](https://omarchy.org)
<a href="https://github.com/tcballard/omarchy-badges"><img src="https://raw.githubusercontent.com/tcballard/omarchy-badges/75975e5b5bf75e7ede3764bcd2950046f7abfe2c/badges/v1/omarchy-plugin.svg" height="20" alt="Built for Omarchy: Plugin"></a>
[![License: MIT](https://img.shields.io/github/license/mscurtescu/omarchy-island-bar)](LICENSE)

[Changelog](CHANGELOG.md) · [Development](DEVELOPMENT.md)

An [Omarchy](https://omarchy.org) bar replacement (`kind: "bar"`): the stock
bar, with **three rounded islands** (left, center, right) on a transparent
strip. Widget layout, clicks, and panels are unchanged.

![Island Bar](preview.png)

This is the Quattro equivalent of the old Waybar pattern: transparent
`window#waybar` and opaque `.modules-left` / `.modules-center` /
`.modules-right` capsules.

Inspired by [Pillbar](https://github.com/fillmefab4/Pillbar).

## See also

- **Munch Solen Dark:** [mscurtescu/omarchy-munch-solen-dark-theme](https://github.com/mscurtescu/omarchy-munch-solen-dark-theme) — indigo rock-shadow theme; the screenshots in that repo show this bar.
- **Munch Solen Light:** [mscurtescu/omarchy-munch-solen-light-theme](https://github.com/mscurtescu/omarchy-munch-solen-light-theme) — straw-paper light sibling, same bar.

Plugin id: `mscurtescu.island-bar`

## Transparency

Same switch as the stock bar. Double-click empty center space, **Style →
Menu Bar → Transparency**, or `omarchy bar transparent toggle`.

- **Off** (default): three islands on a transparent strip
- **On**: islands hidden; widgets sit on the wallpaper with contrast text

`omarchy bar transparent true` / `false` set the look directly.

## Install

```bash
omarchy plugin add https://github.com/mscurtescu/omarchy-island-bar.git --enable
```

Or **Setup → Plugins → Add Plugin**, paste the git URL, and enable when asked.

## Switch back

```bash
omarchy bar reset
```

Or **Setup → Plugins → Enable Plugin** and choose **Bar**.

## Uninstall

```bash
omarchy plugin remove mscurtescu.island-bar
```

Or **Setup → Plugins → Remove Plugin** and choose **Island Bar**.

This removes the plugin directory and restores the stock bar.

## License

[MIT](LICENSE). The bar engine is copied from Omarchy's first-party
`omarchy.bar` (copyright David Heinemeier Hansson). The three-island
overlay on top of that copy is this plugin (copyright 2026 Marius
Scurtescu). Both stay under the same MIT license.
