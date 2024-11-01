  # Git
  alias g='git'

  # Branch (b)
  alias gb='git branch'
  alias gba='git branch --all --verbose'
  alias gbc='git checkout -b'
  alias gbd='git branch --delete'
  alias gbD='git branch --delete --force'
  alias gbl='git branch --verbose'

  # Commit (c)
  alias gc='git commit --verbose'
  alias gca='git commit --verbose --all'
  alias gcm='git commit --message'
  alias gcam='git commit --all --message'
  alias gco='git checkout'
  alias gcF='git commit --verbose --amend'

  # Fetch (f)
  alias gf='git fetch'
  alias gfa='git fetch --all'

  # Grep (g)
  alias gg='git grep'

  # Index (i)
  alias gia='git add'
  alias giA='git add --patch'
  alias giu='git add --update'

  # Log (l)
  alias gl='git log --topo-order --pretty=format:"%C(bold)Commit:%C(reset) %C(green)%H%C(red)%d%n%C(bold)Author:%C(reset) %C(cyan)%an <%ae>%n%C(bold)Date:%C(reset)   %C(blue)%ai (%ar)%C(reset)%n%+B"'
  alias glg='git log --topo-order --graph --pretty=format:"%C(green)%h%C(reset) %s%C(red)%d%C(reset)%n"'

  # Merge (m)
  alias gm='git merge'
  alias gmC='git merge --no-commit'
  alias gmF='git merge --no-ff'
  alias gma='git merge --abort'

  # Push (p)
  alias gp='git push'
  alias gpf='git push --force-with-lease'
  alias gpF='git push --force'
  alias gpc='git push --set-upstream origin "$(git-branch-current 2> /dev/null)"'
  alias gpp='git pull origin "$(git-branch-current 2> /dev/null)" && git push origin "$(git-branch-current 2> /dev/null)"'

  # Rebase (r)
  alias gr='git rebase'
  alias gra='git rebase --abort'
  alias grc='git rebase --continue'
  alias gri='git rebase --interactive'
  alias grs='git rebase --skip'

  # Stash (s)
  alias gs='git stash'
  alias gsa='git stash apply'
  alias gsx='git stash drop'
  alias gsl='git stash list'
  alias gsp='git stash pop'
  alias gsr='git-stash-recover'
  alias gss='git stash save --include-untracked'

  # Tag (t)
  alias gt='git tag'
  alias gtl='git tag --list'

  # Working Copy (w)
  alias gws='git status --ignore-submodules=none --short'
  alias gst='git status'
  alias gwS='git status --ignore-submodules=none'
  alias gwd='git diff --no-ext-diff'
  alias gwD='git diff --no-ext-diff --word-diff'
