# Config improvements — tracking checklist

Scratch file for the config review (2026-09-14). Delete once worked through.

Legend: **[H]** high payoff · **[M]** medium · **[L]** nice-to-have

**Progress:** sections 1-4 complete — 31 commits, `3bd8ea6..9caeaf7`.
Sections 5-7 remain; section 5 (lazygit) is next.

Items that did not survive verification are struck through with the evidence
inline rather than deleted — 4 in section 3 alone. Several others needed a
companion setting to avoid making things worse (`diff.colorMoved`,
`delta.navigate`, `font-family-bold-italic`).

One out-of-repo change was made: `git maintenance start` wrote to `~/.gitconfig`
and created launchd agents. To undo, run `git maintenance unregister` in `~/.files`.

---

## 1. Git — `.config/git/config`

### Correctness / safety
- [x] **[H]** ~~Scope~~ **Removed** `http.sslVerify = false` — it was vestigial. If a host
      ever needs it, scope it: `[http "https://host"] sslVerify = false`  `6270d39`
- [x] **[H]** `color.status = always` → `auto`. Verified it emits escape codes when piped;
      the `sci` alias greps `git st` output and only worked by luck.  `3bd8ea6`

### Missing modern defaults
- [x] **[H]** `diff.algorithm = histogram`  `d4fbaa9`
- [x] **[H]** `merge.conflictStyle = zdiff3` — also activates the `merge-conflict-*`  `f14aa1c`
      styling `mellow-barbet` already defines but that never renders today
- [x] **[H]** `rerere.enabled = true` + `rerere.autoUpdate = true`  `1347e9a`
- [x] **[H]** `rebase.autoStash` / `autoSquash` / `updateRefs = true`  `685d32e`
- [x] **[H]** `push.autoSetupRemote = true`, `push.followTags = true`  `2f14d95`
- [x] **[M]** `pull.rebase = true` (matches the `pr` / `gup` aliases)  `685d32e`
- [x] **[M]** `fetch.prune = true`, `fetch.pruneTags = true`, `fetch.parallel = 0`  `2f14d95`
- [x] **[M]** `diff.renames = copies`, `diff.submodule = log`  `d4fbaa9`
- [x] **[M]** `diff.colorMoved = default` + `diff.colorMovedWS`. Could **not** ship alone:
      verified delta passes git's raw `bold magenta`/`bold cyan` through and the moved
      lines lose mellow-barbet's background. Shipped with a `delta.map-styles` block
      mapping the four move colours to dark tokyonight tints.  `8be92e7`
- [x] **[M]** `branch.sort = -committerdate`, `tag.sort = version:refname`  `7b15eaf`
- [x] **[M]** `commit.verbose = true`  `7356e92`
- [x] **[M]** `core.fsmonitor = true`, `core.untrackedCache = true`  `49ed95d`
- [x] **[L]** `column.ui = auto`, `help.autocorrect = prompt`  `7b15eaf 7356e92`
- [x] **[L]** `diff.tool = nvimdiff` + `difftool.prompt = false` (merge.tool is set, diff.tool isn't)  `8ef8ccc`

### Housekeeping
- [x] **[L]** Ran `git maintenance start` for `~/.files`. Registered `maintenance.repo`
      in **~/.gitconfig** (outside this repo) and loaded the hourly/daily/weekly
      launchd agents — verified via `launchctl list`. Not a tracked change.
- [x] **[L]** `push.default` `upstream` → `simple`; autoSetupRemote covers the
      new-branch case that `upstream` was working around.  `5b3e824`
- [x] **[L]** Add Homebrew `git` to the Brewfile (currently Apple Git 2.50.1)  `afaadca`

---

## 2. Delta

- [x] **[H]** `[interactive] diffFilter = delta --color-only` — `add -p` / `checkout -p` /
      `stash -p` / `reset -p` were the last uncoloured diffs on the machine. Verified
      delta runs in the pipeline and hunks still stage.  `2f61a6e`
- [x] **[H]** `delta.navigate = true`. Could **not** ship alone: delta derives its regex
      from the labels and the derived one omits mellow-barbet's `[*]`, so `n` skipped
      every *modified* file. Shipped with an explicit `navigate-regex`.
      Backslashes are doubled — git config rejects a bare `\[`.  `ee4191f`
- [x] **[M]** `delta.hyperlinks = true`. Needs less >= 581; macOS ships 668. File links
      use the default `file://` (hands the path to the OS, not to nvim) — commit
      links are the reason it is on.  `7d9e58b`
- [x] **[M]** Narrow-pane escape hatch: `[delta "unified"]` + `gdu` abbreviation.
      The `+` in `DELTA_FEATURES=+unified` is load-bearing — bare `unified`
      *replaces* the feature list and loses mellow-barbet entirely.  `08581d0`
- [x] **[L]** Dropped the dead `[delta "catppuccin"]` block.  `1bdf517`
- [x] **[L]** **Decided: trim.** The vendored file contributed 362 of 491 config
      entries for 31 used. Now 161 total. Provenance + refresh notes kept in the
      header. Verified neutral by byte-comparing rendered output (24311 bytes,
      identical) — `delta --show-config` is unreliable for this, it spells style
      names inconsistently between runs.  `1b090ba`

## 3. Ghostty — `.config/ghostty/config.ghostty`

### Fonts
- [x] **[H]** `font-family = Monaspace Neon` — the cask was installed and unused.
      Nerd glyph fallback verified first: powerline separators come from Ghostty's
      internal sprites, the rest from Symbols Nerd Font.  `bba2b16`
- [x] **[H]** `font-family-italic`/`-bold-italic = Monaspace Radon`. Bold-italic needs
      its own line or it falls back to Neon with a synthetic slant.  `bba2b16`
- [x] **[H]** `font-feature = ss01, ss02, ss03, ss09` — set names read out of the font's
      GSUB/name tables, not guessed. **`calt` deliberately omitted**: it *is* Monaspace's
      texture healing and is already on by default.  `ee17705`
- [x] **[M]** `font-thicken = true`, `adjust-cell-height = 8%`, `alpha-blending =
      linear-corrected`  `a39a26f`
- [x] **[L]** Evaluated the family: Neon (neo-grotesque) chosen as the smallest step
      from JetBrains Mono. Argon/Xenon/Krypton/Radon all installed if you want to swap.

### Unused features
- [x] **[M]** `copy-on-select`, `confirm-close-surface = false`, `resize-overlay = never`,
      `mouse-hide-while-typing`, `window-save-state`  `86ccfa9`
- [x] **[M]** `window-padding-x/y` + `balance` + `color = extend`  `86ccfa9`
- [ ] ~~**[H]** Quick terminal~~ — **not viable.** `command` applies to every surface and
      there is no per-surface override (`initial-command` is the `-e` path). A quick
      terminal would run `tmux new-session -A -s __` and attach a *second client to the
      existing session*; the server reports `window-size latest`, so the session would
      resize to whichever client has focus on every toggle. tmux `display-popup`
      already covers this need (`C-a G`, `M-Space`, `C-a i`, `C-a N`).
- [ ] ~~**[L]** `shell-integration = none`~~ — **would be a regression.** fish inside tmux
      *is* receiving the integration: `GHOSTTY_SHELL_FEATURES=cursor:blink,path,title`
      and Ghostty's resources are in `XDG_DATA_DIRS`, inherited zsh → tmux → fish.
- [ ] ~~**[L]** `link = regex:...`~~ — **not implemented in 1.3.1.** The key is recognised
      but returns `error.NotImplemented` (vs `unknown field` for a bogus key).
- [ ] ~~**[L]** `scrollback-limit` down~~ — **skipped, not worth it.** tmux runs on the
      alternate screen so Ghostty's scrollback is never populated, but the saving is
      ~10MB of lazily-allocated memory and it degrades the no-tmux fallback case.

### Hygiene
- [x] **[L]** Documented that all 17 keybinds encode tmux's `C-a` prefix as `\x01`, so
      changing `set -g prefix` breaks them silently.  `f8fd267`

## 4. bat / fd / fzf

- [x] **[H]** `MANPAGER` wired to bat (+ `MANROFFOPT=-c`), in a new `conf.d/pager.fish`.
      `col -bx` is required, not decorative — macOS groff still emits 153
      backspace-overstrike sequences on `man ls` even with `MANROFFOPT=-c`, and they
      reach the terminal as `l^Hl^Hs^Hs` without it.  `15a3e86`
- [x] **[H]** `fd/ignore` expanded to dependency trees, build output and tool caches.
      Honest scope: inside a git repo `.gitignore` already covers most of this; the
      win is plain directories. `-I`/`--no-ignore` still reaches everything.  `0ec4d5a`
- [x] **[M]** fzf popups — **but on `fzf_directory_opts`/`fzf_git_status_opts`/
      `fzf_variables_opts`, not `FZF_DEFAULT_OPTS`.** A global `--tmux` would reach
      fzf processes already running inside a popup and nest: `~/bin/obsidian_notes`
      is launched by `bind N` (a display-popup) and shells out to fzf.  `9caeaf7`
- [x] **[M]** bat `--map-syntax` for `*.ghostty` and `**/tmux/*.conf`. Measured
      before/after: `config.ghostty` and `theme.conf` went plain → highlighted;
      `tmux.conf`/`plugins.conf` already worked. Scoped rather than a blanket
      `*.conf:INI`, which would mis-highlight the tmux files.  `e601fd4`
- [ ] ~~**[L]** bat `--style=plain`~~ — **rejected, it is a downgrade.** bat's default
      already includes grid, header and line numbers; `plain` removes them. The fzf
      previews that want it already pass `--style=plain` explicitly.

### Fallout handled in this section
- [x] Removed `wfxr/tmux-fzf-url` — tmux-fingers' built-in `url` pattern covers
      `https?://`, `git@`, `git://`, `ssh://`, `ftp://`, `file:///`.  `4a30124`
- [x] Removed `sainnhe/tmux-fzf` — unused, and self-bound `prefix+F`.  `42cbbfd`

## 5. lazygit — bound in tmux (`C-a G`), zero config

- [ ] **[H]** Create `.config/lazygit/config.yml`
- [ ] **[H]** `git.paging.pager = delta --paging=never --side-by-side=false`
      (the popup is only 80% wide)
- [ ] **[M]** `gui.nerdFontsVersion: "3"`, tokyonight theme
- [ ] **[M]** `os.edit = nvim {{filename}}` + `editInTerminal: true`

---

## 6. Smaller items

- [ ] **[M]** Replace `thefuck` (unmaintained, Python startup cost) with `pay-respects`
- [ ] **[M]** `README.md` bootstrap is incomplete — add `bat cache --build`
      (custom themes won't load otherwise), `fisher update`, `pre-commit install`
- [ ] **[L]** `eza` and `lsd` both installed; fish uses `lsd`. Drop one, or switch
      to eza for `--git` / `--git-repos`
- [ ] **[L]** mise: `experimental = true` set but `mise tasks` and `[env]` unused
- [ ] **[L]** k9s: only a skin — add `aliases.yaml` / `hotkeys.yaml` (4 k8s tv channels exist)

## 7. Tools worth trying

- [ ] **[M]** `git-absorb` — auto-routes fixups in a stack; pairs with `rebase.autoSquash`
- [ ] **[L]** `difftastic` as a `difftool` for structural diffs
- [ ] **[L]** `carapace` — fish completions for hundreds of CLIs
