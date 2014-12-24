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

An OS X environment with configuration scripts.

## Setup

Note: be careful when following these steps over an existing
configuration, and make sure you have backups in case anything gets
overwritten.

- clone to `~/.dotfiles`
- run `$ git submodule init` and `$ git submodule update --init
  --recursive`
- run `./bin/dots link` to symlink all of the dotfiles into the `$HOME` directory


See additional tasks available by running `./bin/dots tasks`, including
tasks for for backup and troubleshooting.

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

The vim configuration assumes the use of macvim and janus. Plugins are
included in the `./home/.janus` directory as submodules. oh-my-zsh is
used for zsh configuration, and and uses .oh-my-zsh.custom for the
custom directory.

### local

A directory that isn't tracked by git, and can therefore be used for
anything non-public.

### script

OS X-specific scripts for configuring or updating environments.

### vendor

Files and resources that are actively being linked or used by scripts.

## Local Configuration

The following files are expected and should be added to `$HOME` with any
local settings.

- `.gitconfig.local`
- `.hgrc.local`

`*.local` files can also be used to modify other tracked files, including
`.zshrc` and `.bashrc`.
