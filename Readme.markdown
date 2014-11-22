# Dotfiles

## Setup

- clone to `~/.dotfiles`,
- run `rake link` to symlink all of the dotfiles into the `$HOME` directory,
- run `$ git submodule init` and `$ git submodule update --init
  --recursive`

See additional tasks in `Rakefile` (`rake tasks`) for backup and troubleshooting.

## Components

### bin

This is automatically added to `$PATH`, but can also be symlinked from
within `$HOME`.

### config

Configuration files for applications.

### home

All of the dotfiles, and everything at the first level of this directory
should be symlinked into `$HOME`.

Most settings work with both bash and zsh, though zsh is assumed to be
the default.

This configuration assumes the use of janus for base config. Plugins are
included in the `./home/.janus` directory as submodules.

### resources

Other dotfile repos, submoduled. Nothing in this directory is
automatically loaded.

### script

OS X-specific scripts for configuring or updating environments.

## Local Configuration

The following files are expected and should be added to `$HOME` with any
local settings.

- .gitconfig.local
- .hgrc.local
