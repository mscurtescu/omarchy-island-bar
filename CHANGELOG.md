# Changelog

All notable changes to [Island Bar](https://github.com/mscurtescu/omarchy-island-bar)
are documented here.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project uses [Semantic Versioning](https://semver.org/spec/v2.0.0.html)
in `manifest.json`. Omarchy’s plugin updater follows git `HEAD`, not this
version string.

## [Unreleased]

### Added

- Omarchy 4.5 hosting contract: hosted third-party widgets now receive a
  per-widget bar API facade (`IslandPluginBarApi.qml`) mirroring the stock 4.5
  bar — presentation state (foreground, bar foreground, background, urgent,
  font, position, vertical, bar size, transparency, bar-hidden) is bound to
  the island's live values, and popout, click-target and `moduleWidgets`
  access is scoped per widget with ownership tracking. Island-aware widgets
  keep island-bar's own surface on the facade too: the widget registry,
  island inset, click-target press relay and custom-module resolution.
- Per-entry shells for hosted widgets (`EntryShellProxy.qml`): the host's
  `shell.pluginShellForBarEntry` facade composed over island-bar's bar-level
  shell, so a widget's own plugin service resolves as soon as the host
  completes bar-entry facades (omacom/omarchy#13194) and nothing a widget
  reaches today is taken away meanwhile.
- `fixedEdge` injection matching the stock 4.5 widget contract.

### Changed

- Widgets hosted under island-bar no longer see other widgets' popouts as
  their own: `activePopout` and `clickTargets` on the facade are scoped to
  the widget that created them, with a foreign marker for everyone else
  (stock 4.5 semantics). Facades are created per widget per monitor and
  destroyed with the last slot hosting them.

### Fixed

- First-party widget embedding on Omarchy 4.5.0-rc1 verified live
  (`omarchy.media` renders with playback state); the remaining TypeError
  warnings at widget creation come from the pre-injection window that the
  stock 4.5 bar shares, not from island-bar.

On hosts older than 4.5 the facade path is gated off behind a
`pluginShellForBarEntry` capability check and widgets keep receiving the bar
root directly, exactly as in 1.1.0.

## [1.1.0] - 2026-09-01

### Added

- Stock-style transparency toggle: double-click empty center space, **Style →
  Menu Bar → Transparency**, or `omarchy bar transparent toggle`.
  - Off (default): three islands on a transparent strip
  - On: islands hidden; widgets sit on the wallpaper with contrast text

## [1.0.0] - 2026-08-31

### Added

- Omarchy Quattro bar replacement (`mscurtescu.island-bar`) with three rounded
  islands (left, center, right) on a transparent strip.
- Fork of first-party `omarchy.bar` from Omarchy 4.0.2-1; widget layout, clicks,
  and panels unchanged.
- README install/remove, copy-install notes (Omarchy rejects plugin-folder
  symlinks), screenshot, and badges.

[Unreleased]: https://github.com/mscurtescu/omarchy-island-bar/compare/v1.1.0...HEAD
[1.1.0]: https://github.com/mscurtescu/omarchy-island-bar/compare/v1.0.0...v1.1.0
[1.0.0]: https://github.com/mscurtescu/omarchy-island-bar/releases/tag/v1.0.0
