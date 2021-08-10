# dotfiles

I'm turning away from [running vim in docker](https://github.com/johnnymo87/dev-box), and going with the traditional route of installing it locally.

## Installation

1. Because this repository uses git submodules, clone it recusively: `git clone --recurse-submodules git@github.com:johnnymo87/dotfiles.git`.

1. Symlink the necessary files to `~`.

   ```
   ls -s .bash_profile ~
   ls -s .bashrc ~
   ls -s .gitconfig ~
   ls -s .tmux.conf ~
   ls -s .tmux/ ~
   ls -s .vim/ ~
   ls -s .vimrc ~
   ```

1. Install [`jq`](https://github.com/stedolan/jq/releases/latest).

1. Install [`tmux`](https://github.com/tmux/tmux/releases/latest).

1. Install vim from source.

   ```
   curl -LO https://github.com/vim/vim/archive/master.tar.gz && \
     tar -zxvf master.tar.gz && \
     cd vim-master/src && \

     ./configure --prefix=/usr \
                 --with-x \
                 --enable-gui && \
     make && \
     make install

   ```
1. Install [ripgrep](https://github.com/BurntSushi/ripgrep) for faster grepping with [ag.vim](https://github.com/rking/ag.vim).

   ```
   curl -LO https://github.com/BurntSushi/ripgrep/releases/download/0.8.1/ripgrep_0.8.1_amd64.deb && \
     dpkg -i ripgrep_0.8.1_amd64.deb
   ```

## Adding new things

New vim plugins need to be submoduled in `.vim/pack/foo/start/`. New tmux plugins are automatically cloned by `tpm`, so no need to do anything for them.

   ```
   git submodule add <git@github ...> .vim/pack/foo/start/my-new-vim-plugin
   ```
