
    ▓█████▄ ▒█████ ▄▄▄█████▓ ███████▓██▓   ▓█████  ██████
    ▒██▀ ██▒██▒  ██▓  ██▒ ▓▓██   ▓██▓██▒   ▓█   ▀▒██    ▒
    ░██   █▒██░  ██▒ ▓██░ ▒▒████ ▒██▒██░   ▒███  ░ ▓██▄
    ░▓█▄   ▒██   ██░ ▓██▓ ░░▓█▒  ░██▒██░   ▒▓█  ▄  ▒   ██▒
    ░▒████▓░ ████▓▒░ ▒██▒ ░░▒█░  ░██░██████░▒████▒██████▒▒
     ▒▒▓  ▒░ ▒░▒░▒░  ▒ ░░   ▒ ░  ░▓ ░ ▒░▓  ░░ ▒░ ▒ ▒▓▒ ▒ ░
     ░ ▒  ▒  ░ ▒ ▒░    ░    ░     ▒ ░ ░ ▒  ░░ ░  ░ ░▒  ░ ░
     ░ ░  ░░ ░ ░ ▒   ░      ░ ░   ▒ ░ ░ ░     ░  ░  ░  ░
       ░       ░ ░                ░     ░  ░  ░  ░     ░
     ░

# Dotfiles


🅓🅞🅣🅢

An OS X and Linux environment with configuration scripts. Uses the [`bindle`
configuration management tool](https://github.com/alphabetum/bindle).

## Setup

### OS X

Assuming you have [Homebrew](http://brew.sh/) installed, copy the
following and paste it into your terminal:

```bash
brew install alphabetum/taps/bindle && \
bindle init https://github.com/alphabetum/dotfiles.git "$HOME/.dotfiles" && \
bindle bootstrap osx
```

This will take some time to run (it has to pull the submodules) and should

1. install the `bindle` tool,
2. clone the repository to your home directory,
3. add a `~/bin` directory if one is not already present,
4. and add a `~/.bindlerc` configuration file.

Use the [`bindle`](https://github.com/alphabetum/bindle) tool to experiment
with linking files into your environment. `bindle` commands can be discovered
by running `bindle help`.

### Linux

_Warning: The current Linux bootstrapping overwrites existing configuration
files, installs various packages in `$HOME`, and changes the shell to zsh._

Run the following, preferably at the root level of you home directory.

```bash
git clone https://github.com/alphabetum/dotfiles.git "$HOME/.bindle" && \
"$HOME/.bindle/script/bootstrap/linux"
```

## Components

### bin

All of the tracked scripts and binaries, and everything at the first level of
this directory should be symlinked into `$HOME/bin`.

### config

Configuration files for applications.

### home

All of the tracked dotfiles, and everything at the first level of this
directory should be symlinked into `$HOME`.

Most settings work with both bash and zsh, though zsh is assumed to be
the default.

The vim configuration assumes the use of macvim and janus. Plugins are
included in the `./home/.janus` directory as submodules. oh-my-zsh is
used for zsh configuration, and and uses .oh-my-zsh.custom for the
custom directory.

### local

A directory that isn't tracked by git. Can be used for anything non-public.

### script

Scripts for configuring or updating environments.

### vendor

Files and resources that are actively being linked or used by scripts.

## Local Configuration

The following files are expected and should be added to `$HOME` with any
local settings.

- `.gitconfig.local`
- `.hgrc.local`

Other `.local` files can also be used to modify other tracked files. All
of the available `.local` files can be created by copying the
corresponding `.local.example` files into `$HOME` with the `.example`
extension removed.

## More Resources

- [alphabetum/bindle](https://github.com/alphabetum/bindle)
- [alphabetum/dotfile-research](https://github.com/alphabetum/dotfile-research)
