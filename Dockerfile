FROM golang:1.5

ENV EDITOR vim
ENV SHELL zsh

RUN apt-get -q update && \
  apt-get install --no-install-recommends -y --force-yes -q \
    ca-certificates \
    zsh \
    curl \
    git \
    cmake \
    vim \
    && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

RUN go get github.com/nsf/gocode \
           golang.org/x/tools/cmd/goimports \
           github.com/rogpeppe/godef \
           golang.org/x/tools/cmd/oracle \
           golang.org/x/tools/cmd/gorename \
           github.com/golang/lint/golint \
           github.com/kisielk/errcheck \
           github.com/jstemmer/gotags \
           github.com/garyburd/go-explorer/src/getool

# INSTALL PATHOGEN
RUN mkdir -p ~/.vim/autoload ~/.vim/bundle && \
    curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# INSTALL VIM PLUGINS
RUN git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree && \
    git clone https://github.com/fatih/vim-go.git ~/.vim/bundle/vim-go

ADD .vimrc /root/.vimrc
ADD .vimrc.local /root/.vimrc.local
ADD .zshrc /root/.zshrc


