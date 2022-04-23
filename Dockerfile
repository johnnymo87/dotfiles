FROM silkeh/clang:13

ENV TERM xterm-256color

RUN apt update && \
    apt install -y \
    git \
    ninja-build

RUN apt install -y \
    ripgrep \
    tmux \
    vim-gtk3 \
    xclip

ADD . /usr/local/src/cpp-dotfiles/
RUN for x in \
    .bash_profile \
    .bashrc \
    .bashrc.d \
    .gitconfig \
    .tmux.conf \
    .tmux \
    .vim \
    .vimrc \
    ; do ln -sf /usr/local/src/cpp-dotfiles/$x ~/$x; done

WORKDIR /project
