# Development

Island Bar is a copy of first-party `omarchy.bar` plus the island overlay.
Edit this git repo, then copy into the live plugin directory. Omarchy rejects
symlinks inside plugin folders.

## Live copy

```bash
rsync -a --delete --exclude '.git' --exclude '.gitignore' \
  ./ ~/.config/omarchy/plugins/mscurtescu.island-bar/
omarchy plugin validate ~/.config/omarchy/plugins/mscurtescu.island-bar
omarchy bar use mscurtescu.island-bar
omarchy restart shell
```

Run rsync from the repository root. Saving under
`~/.config/omarchy/plugins/` often hot-reloads widgets; the bar Loader can
keep a cached `Bar.qml`, so restart the shell after bar changes.

## Tracking upstream

Engine source:

`$OMARCHY_PATH/shell/plugins/bar/`
https://github.com/basecamp/omarchy/tree/quattro/shell/plugins/bar

After `omarchy update`:

```bash
diff -u "$OMARCHY_PATH/shell/plugins/bar/Bar.qml" Bar.qml
diff -u "$OMARCHY_PATH/shell/plugins/bar/BarModel.js" BarModel.js
```

Keep the island wrapper, transparent window, and non-`required` host
properties. See `UPSTREAM.txt` for the Omarchy package this copy started from.

## Changelog

Record user-facing changes under `## [Unreleased]` in `CHANGELOG.md`.
