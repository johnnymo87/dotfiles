# dotfiles
[My old dotfiles ran vim in docker](https://github.com/johnnymo87/dev-box), but now I'm going with the traditional route of installing everything locally.

My dotfiles mostly deal with three things: vim, tmux, and bash. See [the "Adding new things" section](adding-new-things) for more detail about how I manage the files for these things.

## Installation
Use the OS's recommended package manager to install or update everything mentioned below.

1. If on a mac, [install homebrew](https://brew.sh/) for use as a package manager.

1. Upgrade to the latest version of bash.

1. Install git if it doesn't already exist.

1. [Generate a new SSH key for GitHub](https://docs.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent) and then [add it to GitHub](https://docs.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account).

1. Because this repository uses git submodules, clone it recusively: `git clone --recurse-submodules git@github.com:johnnymo87/dotfiles.git`. Then `cd dotfiles`.

1. Symlink the necessary files to `~`.
   ```
   for x in .bash_profile .bashrc .bashrc.d .gitconfig .tmux.conf .tmux .vim .vimrc; do ln -sf $(pwd)/$x ~/$x; done
   ```

1. Install tmux.

1. Install vim.

1. Install ripgrep for faster grepping with [ag.vim](https://github.com/rking/ag.vim).

1. Finish installing [YouCompleteMe](https://github.com/ycm-core/YouCompleteMe).
   * Install prerequisites, follow [the instructions specific to your operating system](https://github.com/ycm-core/YouCompleteMe)
   * Compile YouCompleteMe
     ```
     cd .vim/pack/foo/start/YouCompleteMe
     git pull --recurse-submodules origin master
     python3 install.py --all --verbose
     ```

1. Install [pyenv](https://github.com/pyenv/pyenv) or delete `.bashrc.d/py.bashrc`.

1. Install [rbenv](https://github.com/rbenv/rbenv) or delete `.bashrc.d/rb.bashrc`.

1. Install rust or delete `.bashrc.d/rust.bashrc`.
   ```
   curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
   ```

## Adding new things
### For vim
I use Vim's built-in package management, see `:help packages`. I submodule all vim plugins in `.vim/pack/foo/start/`. So to add a new vim plugin, do:
```
git submodule add <git@github ...> .vim/pack/foo/start/my-new-vim-plugin
```
To initialize existing submodules (for example, if new ones appear after getting a fresh checkout from `origin`):
```
git submodule update --init --recursive
```

### For tmux
I use [`tpm`](https://github.com/tmux-plugins/tpm) for tmux plugins. So to add a new plugin, simply add a `set -g @plugin '...'` reference to the top of the `.tmux.conf` file, and press `prefix` + <kbd>I</kbd> (capital i, as in **I**nstall) to fetch the plugin.

### For bash
New `*.bashrc` files need to be in the `.bashrc.d` directory, and need to be executable, so do `chmod +x .bashrc.d/*.bashrc` after adding a new one.
