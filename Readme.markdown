# Dotfiles

## Instructions for use

Clone the repository to `~/.dot` and symlink all of the files that are
in the `~/.dot/files` directory.

Run `$ git submodule init` and `$ git submodule update`

## Components

### ./bin

This is automatically added to the PATH, but can also be symlinked from
within HOME.

### ./files

All of the dotfiles, and everything at the first level of this directory
should be symlinked into HOME.

Because there are housekeeping files in the root level of the
repository, particularly git files with the name name as git config
dot files, all of the dot files live in a `files` directory.

This `files` directory has the same structure as the files are intended
to be placed in the home directory, which makes it easy to symlink them
without needing to determine which files should be symlinked or not.

This structure also makes it possible to keep the original filenames, which
should help avoid confusion.

#### vim & janus

This configuration assumes the use of janus for base config. Plugins are
included in the .janus directory as submodules.

### ./scripts

These are scripts intended to be run once on new machines for initial
configuration.

### ./vendor

Other dotfile repos, submoduled. Nothing in this directory is
automatically loaded.

## Local Files

The following files are expected and should be added to ~/ with any
local settings as contents.

- .gitconfig.local
- .hgrc.local
