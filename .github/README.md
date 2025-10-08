# How to properly install this repository on a new machine

## add the dotfile alias in the bashrc file

```bash
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles-bare-repo --work-tree=$HOME"
```

## clone the repository

inside a terminal, run the following commands:

```bash
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles-bare-repo --work-tree=$HOME"
git clone --bare https://github.com/pdicerbo/dotfiles.git $HOME/.dotfiles-bare-repo
dotfiles checkout
```

if this command fails, is because some files are already present in the home directory. (Re)Move the files and try again OR execute `dotfiles checkout -f`.

## prevent untracked files from showing up

```bash
dotfiles config --local status.showUntrackedFiles no
```

## overwrite the bashrc file witht the remote one:

```bash
cp .remote_bashrc $HOME/.bashrc
```

## download delta themes and install it:
```
wget https://raw.githubusercontent.com/dandavison/delta/main/themes.gitconfir
mv themes.gitconfig .themes.gitconfig
```

## install tmux plugins

the first time you run a tmux session, you have to install the plugins inside the tmux config.
to do this, just press
```
prefix + I
```
where `prefix` is `Ctrl + space`.

# Other tools required:

- [cppman](https://aur.archlinux.org/packages/cppman)
- [luajit](https://aur.archlinux.org/packages/luajit-tiktoken-bin)
- [devpod-bin](https://aur.archlinux.org/packages/devpod-bin)

