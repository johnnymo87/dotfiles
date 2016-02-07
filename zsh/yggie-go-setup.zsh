# GO Setup
# don't need GOROOT anymore??
# export GOROOT=/usr/local/go
if [[ -z $TMUX ]]; then
  export GOPATH=$HOME/Code/Go
  export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
fi
