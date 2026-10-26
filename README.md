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

Plugin id: `mscurtescu.island-bar`

## Transparency

Same switch as the stock bar. Double-click empty center space, **Style →
Menu Bar → Transparency**, or `omarchy bar transparent toggle`.

- **Off** (default): three islands on a transparent strip
- **On**: islands hidden; widgets sit on the wallpaper with contrast text

`omarchy bar transparent true` / `false` set the look directly.

## Omarchy 4.5 compatibility

The bar engine is still the Omarchy 4.0.2 fork, but on Omarchy 4.5 hosts the
widget-hosting contract is the stock 4.5 one: hosted third-party widgets get
a per-widget bar API facade (mirrored presentation state, scoped popout and
click-target ownership) and a per-entry shell composed over island-bar's
bar-level shell, so widgets written against `omarchy.bar` on 4.5 behave the
same under island-bar. Island-aware widgets (the tray drawer and friends)
additionally keep island-bar's own hosting surface on the facade — the
widget registry, island inset, click-target press relay and custom-module
resolution. Hosts older than 4.5 keep the previous direct-bar-root
injection, unchanged. First-party widgets (`omarchy.media`, `omarchy.clock`,
`omarchy.workspaces`, …) are embedded the same way on every host version.

Widget-level 4.5 features travel with the widgets themselves and work under
island-bar: scrolling the workspaces island, per-monitor workspaces, and the
clock's seconds format (set the format on the widget entry in `shell.json`).

What 4.5's first-party bar has that island-bar does not: hosting widgets
inside the tray's drawer, the new drag-to-rearrange arrangement UX (island-bar
keeps its own drag-rearrange from 4.0.2), and 4.5's cross-widget icon metrics.
The bar remains a third-party host, so a widget's `bar.shell.serviceFor()`
resolves its own plugin service once the host completes bar-entry facades
([omacom/omarchy#13194](https://github.com/omacom/omarchy/pull/13194)).

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

## See also

- **Munch Solen Dark:** [mscurtescu/omarchy-munch-solen-dark-theme](https://github.com/mscurtescu/omarchy-munch-solen-dark-theme) — indigo rock-shadow theme; the screenshots in that repo show this bar.
- **Munch Solen Light:** [mscurtescu/omarchy-munch-solen-light-theme](https://github.com/mscurtescu/omarchy-munch-solen-light-theme) — straw-paper light sibling, same bar.

## License

[MIT](LICENSE). The bar engine is copied from Omarchy's first-party
`omarchy.bar` (copyright David Heinemeier Hansson). The three-island
overlay on top of that copy is this plugin (copyright 2026 Marius
Scurtescu). Both stay under the same MIT license.
