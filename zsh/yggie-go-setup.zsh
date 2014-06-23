# GO Setup
if [[ -z $TMUX ]]; then
  export GOPATH=$HOME/Code/Go
  export GOROOT=/usr/local/go
  export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
fi
