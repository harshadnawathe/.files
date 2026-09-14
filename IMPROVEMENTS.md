# Config improvements — tracking checklist

Scratch file for the config review (2026-09-14). Delete once worked through.

Legend: **[H]** high payoff · **[M]** medium · **[L]** nice-to-have

**Progress:** section 1 (git) done bar two decisions — see `http.sslVerify` and
`push.default` below. Sections 2-7 untouched.

---

## 1. Git — `.config/git/config`

### Correctness / safety
- [ ] **[H]** Scope `http.sslVerify = false` to the one host that needs it, or drop it.
      Currently global — disables TLS verification for every clone/fetch/push.
      `[http "https://host.example.com"] sslVerify = false`
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
- [ ] **[L]** Run `git maintenance start` instead of invoking the `cc` alias by hand
- [ ] **[L]** Decide on `push.default = upstream` vs `simple`
- [x] **[L]** Add Homebrew `git` to the Brewfile (currently Apple Git 2.50.1)  `afaadca`

---

## 2. Delta

- [ ] **[H]** `[interactive] diffFilter = delta --color-only`
      Biggest single win — `git add -p` currently shows raw uncolored diffs.
- [ ] **[H]** `delta.navigate = true` (verified `false`) — n/N between files
- [ ] **[M]** `delta.hyperlinks = true` (verified `false`) — Ghostty renders OSC-8
- [ ] **[M]** Narrow-pane escape hatch: add `[delta "unified"] side-by-side = false`
      and `abbr -a gdu 'DELTA_FEATURES=+unified git diff'`
- [ ] **[L]** Drop the dead `[delta "catppuccin"]` block from `git/config`
- [ ] **[L]** Decide: trim `delta/themes/gitconfig.inc` to `mellow-barbet` only,
      or keep it pristine for easy upstream refresh

---

## 3. Ghostty — `.config/ghostty/config.ghostty`

### Fonts
- [ ] **[H]** Set `font-family` — `font-monaspace` is installed via Brewfile and unused.
      `Monaspace Neon` + `font-family-italic = Monaspace Radon`
- [ ] **[H]** `font-feature = calt, liga, ss01..ss08` (enables texture healing)
- [ ] **[M]** `font-thicken = true`, `adjust-cell-height = 8%`
- [ ] **[L]** Evaluate `Argon` (humanist) / `Xenon` (slab) before settling

### Unused features
- [ ] **[H]** Quick terminal: `quick-terminal-position = top` +
      `keybind = global:cmd+grave_accent=toggle_quick_terminal`
- [ ] **[M]** `copy-on-select = clipboard`
- [ ] **[M]** `confirm-close-surface = false` (tmux persists everything)
- [ ] **[M]** `resize-overlay = never`
- [ ] **[M]** `window-padding-x/y` + `window-padding-balance` + `window-padding-color = extend`
- [ ] **[M]** `alpha-blending = linear-corrected` (text over the wallpaper)
- [ ] **[L]** `mouse-hide-while-typing = true`, `window-save-state = always`
- [ ] **[L]** `scrollback-limit` down — tmux owns scrollback
- [ ] **[L]** `shell-integration = none` — injected into zsh, made moot by tmux
- [ ] **[L]** `link = regex:PROJ-\d+,action:open:https://jira/browse/$0`

### Hygiene
- [ ] **[L]** Comment that every `text:\x01…` keybind hard-codes tmux's `C-a` prefix

---

## 4. bat / fd / fzf

- [ ] **[H]** `MANPAGER` is unset — wire bat in for colored man pages (+ `MANROFFOPT=-c`)
- [ ] **[H]** `fd/ignore` holds only `.git/` — add `node_modules/`, `target/`,
      `.venv/`, `build/`, `dist/`, `.gradle/`
- [ ] **[M]** fzf `--tmux center,80%,70%` in `FZF_DEFAULT_OPTS` — float in a tmux popup
      instead of clobbering the pane (fzf 0.74 supports it)
- [ ] **[M]** bat `--map-syntax "*.ghostty:INI"` — the sesh preview for the ghostty
      config renders unhighlighted today. Also `*.conf:INI`, `tmux.conf:bash`
- [ ] **[L]** bat `--style=plain`

---

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
