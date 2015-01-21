
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

An OS X and Ubuntu environment with configuration scripts. Uses the [`dots`
configuration management tool](https://github.com/alphabetum/dots).

## Setup

### OS X

Assuming you have [Homebrew](http://brew.sh/) installed, copy the
following and paste it into your terminal:

    brew install alphabetum/taps/dots && \
    dots init https://github.com/alphabetum/dotfiles.git ~/.dotfiles && \
    ~/.dotfiles/script/bootstrap/osx

This will take some time to run and should

1. install the `dots` tool,
2. clone the repository to your home directory
3. add a `~/bin` directory if one is not already present
4. and add a `~/.dotsrc` configuration file.

Use the [`dots`](https://github.com/alphabetum/dots) tool to experiment with linking files into your environment and experimenting. `dots` commands can be
discovered by running `dots help`.

### Ubuntu

_Warning: The current Ubuntu bootstrapping overwrites existing configuration
files, installs various packages, and changes the shell to zsh._

1. Clone this repository to `~/.dotfiles`
2. Run the `~/.dotfiles/script/bootstrap/ubuntu` script

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
