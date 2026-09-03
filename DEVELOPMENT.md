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

## Checks

```bash
omarchy plugin validate .
node tests/bar-model.test.js
```

`omarchy plugin validate` checks the manifest schema. The node tests cover
`BarModel.js` (layout helpers). They do not exercise `Bar.qml` or the islands.

Or: `task lint` and `task validate` (lint already runs the node tests).

## Pre-commit

[Lefthook](https://github.com/evilmartians/lefthook) runs those checks on
`git commit`. Pin is in `.mise.toml` (`lefthook` 2.1.12).

```bash
task setup
```

That runs `mise install` and `lefthook install`. On a brand-new clone, install mise tools first so `task` exists: `mise install && task setup`.

`lefthook.yml` calls `task lint` and `task validate` via `mise exec` so git
hooks see the pinned tools. Skip once with `LEFTHOOK=0 git commit`.

## Tickets (Beads)

This repo uses [Beads](https://github.com/gastownhall/beads) (`bd`) with
embedded Dolt. Pin is in `.mise.toml` (`aqua:gastownhall/beads` 1.2.2).
Issue IDs use the `ib-` prefix.

```bash
mise install
bd create "…"
bd ready
bd update <id> --claim
bd close <id>
bd dolt push    # sync the Dolt DB to origin refs/dolt/data
bd dolt pull
```

`bd prime` prints agent workflow context. Beads git hooks were not installed
(`bd hooks install` later if you want them; compose with lefthook, do not
replace it).

## Changelog

Record user-facing changes under `## [Unreleased]` in `CHANGELOG.md`.
