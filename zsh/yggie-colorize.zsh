if [ uname = "Linux" ]; then
  if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  fi

  alias ls="ls -F --color=auto"
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'

  # keep grep colors nice and pretty
  export GREP_COLORS="fn=34:mc=01;30:ms=33:sl=21:cx=31"

  # keep .dircolors configuration when using tab completion
  zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
fi

# so that tmux uses the right colors
alias tmux='TERM=screen-256color-bce tmux'
alias tmate='TERM=screen-256color-bce tmate'
