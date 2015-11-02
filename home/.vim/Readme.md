# .vim

## Janus

[Janus](https://github.com/carlhuda/janus) is a distribution of plug-ins and mappings for Vim, Gvim and MacVim.

[`home/.vim.janus/janus`](../vim.janus/janus) is the primary directory for
the Janus distribution.

The [`.vim.janus`](../.vim.janus) submodule contains plugins as submodules,
which need to be loaded and updated either manually or using the `rake`
command.

[home/.janus](../.janus) is a [pathogen](https://github.com/tpope/vim-pathogen) directory.

### Additional Files

- [`home/.gvimrc.after`](../.gvimrc.after)
- [`home/.vimrc.before`](../.vimrc.before)
- [`home/.vimrc.after`](../.vimrc.after)

## Neovim

[Neovim](https://neovim.io) is a fork of vim focused on extensibility and
agility.

[`home/.config/nvim`](../.config/nvim) is Neovim's configuration location.
In this configuration, it links to `~/.vim`. [`init.vim`](./init.vim) is
the Neovim equivalent of [`.vimrc`](../.vimrc), which is linked in `~/.vim`
to make it available to Neovim.

More information:
*[Transitioning from Vim \[to Neovim\]
(neovim.io)](https://neovim.io/doc/user/nvim_from_vim.html)*

## `vim` Wrapper

[`bin/vim`](../../bin/vim) wraps `vim` and `nvim`, using `nvim` when
present and configured, and otherwise falls back to `nvim.`
