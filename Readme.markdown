         _____        ___                 ___                            ___          ___
        /  /::\      /  /\        ___    /  /\    ___                   /  /\        /  /\
       /  /:/\:\    /  /::\      /  /\  /  /:/_  /  /\                 /  /:/_      /  /:/_
      /  /:/  \:\  /  /:/\:\    /  /:/ /  /:/ /\/  /:/   ___     ___  /  /:/ /\    /  /:/ /\
     /__/:/ \__\:|/  /:/  \:\  /  /:/ /  /:/ /:/__/::\  /__/\   /  /\/  /:/ /:/_  /  /:/ /::\
     \  \:\ /  /:/__/:/ \__\:\/  /::\/__/:/ /:/\__\/\:\_\  \:\ /  /:/__/:/ /:/ /\/__/:/ /:/\:\
      \  \:\  /:/\  \:\ /  /:/__/:/\:\  \:\/:/    \  \:\/\  \:\  /:/\  \:\/:/ /:/\  \:\/:/~/:/
       \  \:\/:/  \  \:\  /:/\__\/  \:\  \::/      \__\::/\  \:\/:/  \  \::/ /:/  \  \::/ /:/
        \  \::/    \  \:\/:/      \  \:\  \:\      /__/:/  \  \::/    \  \:\/:/    \__\/ /:/
         \__\/      \  \::/        \__\/\  \:\     \__\/    \__\/      \  \::/       /__/:/
                     \__\/               \__\/                          \__\/        \__\/

# Dotfiles

🅓🅞🅣🅢

An OS X environment with configuration scripts. Uses the [`dots`
configuration management tool](https://github.com/alphabetum/dots).

## Setup

Add the [`dots` tool](https://github.com/alphabetum/dots) to your `$PATH`.

Create a `$HOME/bin` directory if one doesn't already exist.

_Note_: be careful when following these steps over an existing
configuration, and make sure you have backups in case anything gets
overwritten. It might be better to take each step individually.

If you are ready to live on the edge and go wild, copy the following and paste
it into your terminal:

    git clone https://github.com/alphabetum/dotfiles.git ~/.dotfiles && \
    cd ~/.dotfiles && \
    git submodule init && git submodule update --init --recursive && \
    ./bin/dots link && ./bin/dots bin link

This should clone the repository to your home directory and link all
files, excluding any that you already have in `$HOME` and `~/bin` that have the
same name as any of the files in the repository.

Use the [`dots`]((https://github.com/alphabetum/dots) tool (which should
be available at `~/bin/dots` after the above steps) to handle the
additional files and experiment with everything.

See additional tasks available by running `~/bin/dots commands`, including
commands for for backup and troubleshooting.

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

OS X-specific scripts for configuring or updating environments.

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
