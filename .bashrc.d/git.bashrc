alias gs="git status"
alias gco="git checkout"
alias gd="git diff"
alias gb="git branch"
alias gl="git log"
alias gp="git push"

function gcom () {
  git fetch origin && git checkout origin/$(git remote show origin | grep "HEAD branch:" | awk '{ print $3 }')
}

function filesAt () {
  git show HEAD~$1 --name-status | grep "^[M|A]\t" | awk '{ print $2 '}
}
