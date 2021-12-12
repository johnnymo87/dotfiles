# dotfiles

I'm turning away from [running vim in docker](https://github.com/johnnymo87/dev-box), and going with the traditional route of installing it locally.

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
     python3 install.py --all --verbose
     ```

## Adding new things
I use Vim's built-in package management, see `:help packages`. New vim plugins need to be submoduled in `.vim/pack/foo/start/`.
```
git submodule add <git@github ...> .vim/pack/foo/start/my-new-vim-plugin
```

New tmux plugins are automatically cloned by `tpm`, so no need to do anything for them.

New `*.bashrc` files need to be in the `.bashrc.d` directory, and need to be executable, so do `chmod +x .bashrc.d/*.bashrc` after adding a new one.
