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

function filesStaged () {
  gd --cached --name-status | grep "^[M|A]\t" | awk '{ print $2 '}
}

# Tired of digging through stashes trying to find where you stashed that one change?
# This function scans through your entire stash stack and finds which stashes contain
# changes to a specific file. Born out of frustration after one too many instances of
# "I know I stashed that config change somewhere..." Perfect for those moments when
# you've been trigger-happy with git stash and can't remember which stash has your
# precious changes. Usage is dead simple: find-in-stashes path/to/your/file
function find-in-stashes() {
    if [ -z "$1" ]; then
        echo "Usage: find-in-stashes <file-path>"
        return 1
    fi
    git stash list | cut -d: -f1 | while read stash; do
        git stash show -p "$stash" | grep -l "$1" > /dev/null && echo "$stash contains the file"
    done
}
