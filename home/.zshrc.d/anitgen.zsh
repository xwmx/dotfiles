###############################################################################
# Antigen
#
# A plugin manager for zsh, inspired by oh-my-zsh and vundle.
#
# http://antigen.sharats.me/
# https://github.com/zsh-users/antigen
###############################################################################

source "$HOME/.antigen/antigen.zsh"

# zsh-completions
#
# Additional completion definitions for Zsh.
#
# https://github.com/zsh-users/zsh-completions
antigen bundle zsh-users/zsh-completions src

# zsh-syntax-highlighting
#
# Fish shell like syntax highlighting for Zsh.
#
# https://github.com/zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-syntax-highlighting

antigen-apply
