# dotfiles
[My old dotfiles ran vim in docker](https://github.com/johnnymo87/dev-box), but now I'm going with the traditional route of installing everything locally.

My dotfiles mostly deal with three things: vim, tmux, and bash. See [the "Adding new things" section](adding-new-things) for more detail about how I manage the files for these things.

## Installation
Use the OS's recommended package manager to install or update everything mentioned below.

1. If on a mac, [install homebrew](https://brew.sh/) for use as a package manager.

1. Upgrade to the latest version of bash.

1. Install git if it doesn't already exist.

1. [Set up GPG commit signing](https://docs.github.com/en/authentication/managing-commit-signature-verification/signing-commits) and [tell git about your signing key](https://docs.github.com/en/authentication/managing-commit-signature-verification/telling-git-about-your-signing-key) (`.gitconfig` has `commit.gpgsign = true`).

1. [Generate a new SSH key for GitHub](https://docs.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent) and then [add it to GitHub](https://docs.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account).

1. Because this repository uses git submodules, clone it recusively: `git clone --recurse-submodules git@github.com:johnnymo87/dotfiles.git`. Then `cd dotfiles`.

1. Symlink the necessary files to `~`.
   ```
   for x in .bash_profile .bashrc .bashrc.d .config/nvim .gitconfig .gitignore_global .tmux.conf .tmux; do ln -sf $(pwd)/$x ~/$x; done
   ln -sf $(pwd)/.claude/statusline.sh ~/.claude/statusline.sh
   ln -sf $(pwd)/.claude/hooks ~/.claude/hooks

   # Symlink Claude Code skills (both personal and company skills into ~/.claude/skills/)
   mkdir -p ~/.claude/skills
   for skill in $(pwd)/.claude/skills/*/; do
     [ -d "$skill" ] && ln -sf "$skill" ~/.claude/skills/$(basename "$skill")
   done
   for skill in $(pwd)/.claude/skills.private/*/; do
     [ -d "$skill" ] && ln -sf "$skill" ~/.claude/skills/$(basename "$skill")
   done

   # Symlink Claude Code custom slash commands (both personal and company commands)
   mkdir -p ~/.claude/commands
   for cmd in $(pwd)/.claude/commands/*.md; do
     [ -f "$cmd" ] && ln -sf "$cmd" ~/.claude/commands/$(basename "$cmd")
   done
   for cmd in $(pwd)/.claude/commands.private/*.md; do
     [ -f "$cmd" ] && ln -sf "$cmd" ~/.claude/commands/$(basename "$cmd")
   done
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

1. Install [direnv](https://github.com/direnv/direnv) or delete `.bashrc.d/direnv.bashrc`.

1. Install [pyenv](https://github.com/pyenv/pyenv) or delete `.bashrc.d/py.bashrc`.
   * For data science things, consider installing [miniconda](https://docs.conda.io/en/latest/miniconda.html) as well. After installing, run `conda init`. This will modify some general rc files (e.g. `.bash_profile`). Relocate these changes to `.bashrc.d/conda.private.bashrc`. (This configuration is shell- and installation-specific, so we don't check it into version control.)

1. Install [rbenv](https://github.com/rbenv/rbenv) or delete `.bashrc.d/rb.bashrc`.

1. Install rust or delete `.bashrc.d/rust.bashrc`.
   ```
   curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
   ```
1. For Elixir:
   * If you don't want Elixir, just delete `.bashrc.d/asdf.bashrc`.
   * Otherwise, [install asdf](https://asdf-vm.com/guide/getting-started.html).
   * Install Elixir with asdf.
     ```
     asdf plugin add elixir
     asdf install elixir latest
     ```
   * Install Erlang with asdf.
     ```
     asdf plugin add erlang
     asdf install erlang latest
     ```
   * Install mix.
     ```
     mix local.hex
     ```

1. For a prettier shell prompt, install one of these [Nerd Fonts](https://www.nerdfonts.com/font-downloads) and [Starship](https://starship.rs/).
   * E.g. I'm currently using `font-fira-code-nerd-font`.

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

### For Claude Code
1. Install Claude Code:
   ```
   curl -fsSL https://claude.ai/install.sh | bash
   ```

2. Authenticate with Claude Code (restart your shell first to pick up the PATH from `.bashrc.d/claude.bashrc`):
   ```
   claude
   ```
   Then type `/login` and follow the prompts.

3. Configure the status line. After symlinking `statusline.sh` from step 6 of Installation, update `~/.claude/settings.json` to include:
   ```json
   {
     "statusLine": {
       "type": "command",
       "command": "~/.claude/statusline.sh"
     }
   }
   ```

4. **Claude Code Skills**: Skills are packaged instructions that extend Claude's capabilities. This repository manages two types:

   **Directory Structure**:
   ```
   dotfiles/.claude/
   ├── skills/              (version controlled personal skills)
   └── skills.private/      (NOT version controlled company skills)

   ~/.claude/
   └── skills/              (contains symlinks to individual skills from both sources)
   ```

   - **Personal Skills** (source: `dotfiles/.claude/skills/`):
     - Portable skills that work across any company or project
     - Version controlled in this repository
     - Symlinked to `~/.claude/skills/`
     - Examples: Generic coding patterns, tool workflows (git, docker), debugging techniques

   - **Company Skills** (source: `dotfiles/.claude/skills.private/`):
     - Company-specific workflows and infrastructure
     - Managed in dotfiles repo but NOT version controlled (excluded via `.gitignore`)
     - Symlinked to `~/.claude/skills/` alongside personal skills
     - Examples: Internal tool access, company infrastructure patterns
     - Backup via work-provided cloud storage (e.g., Google Drive) before migrating to new machine

   For detailed guidance on creating and organizing skills, see the "Creating Claude Code Skills" skill in `.claude/skills/creating-claude-code-skills/`.

5. **Claude Code Commands**: Custom slash commands invoked with `/command-name`. Same pattern as skills:

   **Directory Structure**:
   ```
   dotfiles/.claude/
   ├── commands/              (version controlled personal commands)
   └── commands.private/      (NOT version controlled company commands)

   ~/.claude/
   └── commands/              (contains symlinks to commands from both sources)
   ```

   - **Personal Commands** (source: `dotfiles/.claude/commands/`):
     - Portable commands that work across any company or project
     - Version controlled in this repository
     - Examples: `/so-question` for drafting Stack Overflow questions

   - **Company Commands** (source: `dotfiles/.claude/commands.private/`):
     - Company-specific workflows
     - Managed in dotfiles repo but NOT version controlled (excluded via `.gitignore`)
     - Examples: `/fr-incident-response` for Fresh Realm incident handling
     - Backup via work-provided cloud storage before migrating to new machine
