abbr -a gal 'git all'
abbr -a g git
abbr -a ga 'git add'
abbr -a gaa 'git add --all'
abbr -a gam 'git am'
abbr -a gama 'git am --abort'
abbr -a gamc 'git am --continue'
abbr -a gams 'git am --skip'
abbr -a gamscp 'git am --show-current-patch'
abbr -a gap 'git apply'
abbr -a gapa 'git add --patch'
abbr -a gapt 'git apply --3way'
abbr -a gau 'git add --update'
abbr -a gav 'git add --verbose'
abbr -a gb 'git branch'
abbr -a gbD 'git branch -D'
abbr -a gba 'git branch -a'
abbr -a gbd 'git branch -d'
abbr -a gbda 'git branch --no-color --merged | command grep -vE "^([+*]|\s*($(git_main_branch)|$(git_develop_branch))\s*$)" | command xargs git branch -d 2>/dev/null'
abbr -a gbl 'git blame -b -w'
abbr -a gbnm 'git branch --no-merged'
abbr -a gbr 'git branch --remote'
abbr -a gbs 'git bisect'
abbr -a gbsb 'git bisect bad'
abbr -a gbsg 'git bisect good'
abbr -a gbsr 'git bisect reset'
abbr -a gbss 'git bisect start'
abbr -a gc 'git commit -v'
abbr -a 'gc!' 'git commit -v --amend'
abbr -a gca 'git commit -v -a'
abbr -a 'gca!' 'git commit -v -a --amend'
abbr -a gcam 'git commit -a -m'
abbr -a 'gcan!' 'git commit -v -a --no-edit --amend'
abbr -a 'gcans!' 'git commit -v -a -s --no-edit --amend'
abbr -a gcas 'git commit -a -s'
abbr -a gcasm 'git commit -a -s -m'
abbr -a gcb 'git checkout -b'
abbr -a gcd 'git checkout $(git_develop_branch)'
abbr -a gcf 'git config --list'
abbr -a gcl 'git clone --recurse-submodules'
abbr -a gclean 'git clean -id'
abbr -a gcm 'git checkout $(git_main_branch)'
abbr -a gcmsg 'git commit -m'
abbr -a 'gcn!' 'git commit -v --no-edit --amend'
abbr -a gco 'git checkout'
abbr -a gcor 'git checkout --recurse-submodules'
abbr -a gcount 'git shortlog -sn'
abbr -a gcp 'git cherry-pick'
abbr -a gcpa 'git cherry-pick --abort'
abbr -a gcpc 'git cherry-pick --continue'
abbr -a gcs 'git commit -S'
abbr -a gcsm 'git commit -s -m'
abbr -a gcss 'git commit -S -s'
abbr -a gcssm 'git commit -S -s -m'
abbr -a gd 'git diff'
abbr -a gdca 'git diff --cached'
abbr -a gdct 'git describe --tags $(git rev-list --tags --max-count=1)'
abbr -a gdcw 'git diff --cached --word-diff'
abbr -a gds 'git diff --staged'
abbr -a gdt 'git diff-tree --no-commit-id --name-only -r'
abbr -a gdup 'git diff @{upstream}'
abbr -a gdw 'git diff --word-diff'
abbr -a gf 'git fetch'
abbr -a gfa 'git fetch --all --prune --jobs=10'
abbr -a gfg 'git ls-files | grep'
abbr -a gfo 'git fetch origin'
abbr -a gg 'git gui citool'
abbr -a gga 'git gui citool --amend'
abbr -a ggpull 'git pull origin "$(git_current_branch)"'
abbr -a ggpush 'git push origin "$(git_current_branch)"'
abbr -a ggsup 'git branch --set-upstream-to=origin/$(git_current_branch)'
abbr -a ghh 'git help'
abbr -a gignore 'git update-index --assume-unchanged'
abbr -a gignored 'git ls-files -v | grep "^[[:lower:]]"'
abbr -a git-svn-dcommit-push 'git svn dcommit && git push github $(git_main_branch):svntrunk'
abbr -a gk '\gitk --all --branches &!'
abbr -a gke '\gitk --all $(git log -g --pretty=%h) &!'
abbr -a gl 'git pull'
abbr -a glg 'git log --stat'
abbr -a glgg 'git log --graph'
abbr -a glgga 'git log --graph --decorate --all'
abbr -a glgm 'git log --graph --max-count=10'
abbr -a glgp 'git log --stat -p'
abbr -a glo 'git log --oneline --decorate'
abbr -a glod 'git log --graph --pretty='\''%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset'\'
abbr -a glods 'git log --graph --pretty='\''%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset'\'' --date=short'
abbr -a glog 'git log --oneline --decorate --graph'
abbr -a gloga 'git log --oneline --decorate --graph --all'
abbr -a glol 'git log --graph --pretty='\''%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'\'
abbr -a glola 'git log --graph --pretty='\''%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'\'' --all'
abbr -a glols 'git log --graph --pretty='\''%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'\'' --stat'
abbr -a glp _git_log_prettily
abbr -a glum 'git pull upstream $(git_main_branch)'
abbr -a gm 'git merge'
abbr -a gma 'git merge --abort'
abbr -a gmom 'git merge origin/$(git_main_branch)'
abbr -a gmtl 'git mergetool --no-prompt'
abbr -a gmtlvim 'git mergetool --no-prompt --tool=vimdiff'
abbr -a gmum 'git merge upstream/$(git_main_branch)'
abbr -a gp 'git push'
abbr -a gpd 'git push --dry-run'
abbr -a gpf 'git push --force-with-lease'
abbr -a 'gpf!' 'git push --force'
abbr -a gpoat 'git push origin --all && git push origin --tags'
abbr -a gpr 'git pull --rebase'
abbr -a gpristine 'git reset --hard && git clean -dffx'
abbr -a gpsup 'git push --set-upstream origin $(git_current_branch)'
abbr -a gpu 'git push upstream'
abbr -a gpv 'git push -v'
abbr -a gr 'git remote'
abbr -a gra 'git remote add'
abbr -a grb 'git rebase'
abbr -a grba 'git rebase --abort'
abbr -a grbc 'git rebase --continue'
abbr -a grbd 'git rebase $(git_develop_branch)'
abbr -a grbi 'git rebase -i'
abbr -a grbm 'git rebase $(git_main_branch)'
abbr -a grbo 'git rebase --onto'
abbr -a grbom 'git rebase origin/$(git_main_branch)'
abbr -a grbs 'git rebase --skip'
abbr -a grep 'grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}'
abbr -a grev 'git revert'
abbr -a grh 'git reset'
abbr -a grhh 'git reset --hard'
abbr -a grm 'git rm'
abbr -a grmc 'git rm --cached'
abbr -a grmv 'git remote rename'
abbr -a groh 'git reset origin/$(git_current_branch) --hard'
abbr -a grrm 'git remote remove'
abbr -a grs 'git restore'
abbr -a grset 'git remote set-url'
abbr -a grss 'git restore --source'
abbr -a grst 'git restore --staged'
abbr -a grt 'cd "$(git rev-parse --show-toplevel || echo .)"'
abbr -a gru 'git reset --'
abbr -a grup 'git remote update'
abbr -a grv 'git remote -v'
abbr -a gsb 'git status -sb'
abbr -a gsd 'git svn dcommit'
abbr -a gsh 'git show'
abbr -a gsi 'git submodule init'
abbr -a gsps 'git show --pretty=short --show-signature'
abbr -a gsr 'git svn rebase'
abbr -a gss 'git status -s'
abbr -a gst 'git status'
abbr -a gsta 'git stash push'
abbr -a gstaa 'git stash apply'
abbr -a gstall 'git stash --all'
abbr -a gstc 'git stash clear'
abbr -a gstd 'git stash drop'
abbr -a gstl 'git stash list'
abbr -a gstp 'git stash pop'
abbr -a gsts 'git stash show --text'
abbr -a gsu 'git submodule update'
abbr -a gsw 'git switch'
abbr -a gswc 'git switch -c'
abbr -a gswd 'git switch $(git_develop_branch)'
abbr -a gswm 'git switch $(git_main_branch)'
abbr -a gtl 'gtl(){ git tag --sort=-v:refname -n -l "${1}*" }; noglob gtl'
abbr -a gts 'git tag -s'
abbr -a gtv 'git tag | sort -V'
abbr -a gunignore 'git update-index --no-assume-unchanged'
abbr -a gunwip 'git log -n 1 | grep -q -c "\-\-wip\-\-" && git reset HEAD~1'
abbr -a gup 'git pull --rebase'
abbr -a gupa 'git pull --rebase --autostash'
abbr -a gupav 'git pull --rebase --autostash -v'
abbr -a gupom 'git pull --rebase origin $(git_main_branch)'
abbr -a gupomi 'git pull --rebase=interactive origin $(git_main_branch)'
abbr -a gupv 'git pull --rebase -v'
abbr -a gwch 'git whatchanged -p --abbrev-commit --pretty=medium'
abbr -a gwip 'git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign -m "--wip-- [skip ci]"'
