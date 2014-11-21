# Dotfiles

## Instructions for use

Clone the repository to `~/.dotfiles` and run `rake link` to symlink all of
the dotfiles into the `$HOME` directory. See additional tasks in
`Rakefile` (`rake tasks`) for backup and troubleshooting tasks.

Run `$ git submodule init` and `$ git submodule update`

## Components

### ./bin

This is automatically added to the `$PATH`, but can also be symlinked from
within `$HOME`.

### ./home

All of the dotfiles, and everything at the first level of this directory
should be symlinked into `$HOME`.

Because there are housekeeping files in the root level of the
repository, particularly git files with the same name as git config
dot files, all of the dot files live in a `./home` directory.

This `./home` directory has the same structure as the files are intended
to be placed in the `$HOME` directory, which makes it easy to symlink them
without needing to determine which files should be symlinked or not.

This structure also makes it possible to keep the original filenames, which
should help avoid confusion.

#### vim & janus

This configuration assumes the use of janus for base config. Plugins are
included in the `./home/.janus` directory as submodules.

### ./script

These are scripts intended to be run once on new machines for initial
configuration.

### ./resources

Other dotfile repos, submoduled. Nothing in this directory is
automatically loaded.

## Local Files

The following files are expected and should be added to `$HOME` with any
local settings as contents.

- .gitconfig.local
- .hgrc.local
