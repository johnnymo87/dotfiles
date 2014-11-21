# Global aliases
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g C='| wc -l'
alias -g H='| head'
alias -g L="| less"
alias -g N="| /dev/null"
alias -g S='| sort'
alias -g G='| grep' # now you can do: ls foo G something

# line counts of the top ten longest files in a ruby app
alias -g rbc="find . -name '*.rb' | xargs wc -l | sort -n | tail -10"

# Functions

# (f)ind by (n)ame
# usage: fn foo 
# to find all files containing 'foo' in the name
function fn() { ls **/*$1* }

# usage: vimmodified 1
# to open all files modified from '1' commit ago as buffers in vim
function vimmodified() { git diff --name-only HEAD HEAD~$1 | xargs -o vim -p }

# http://joey.aghion.com/find-the-github-pull-request-for-a-commit/
export GITHUB_UPSTREAM=upstream

export bb='@{-1}' # refers to the previous branch

# from brew install coreutils
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

function pr_for_sha {
  git describe --all --contains $1
}
