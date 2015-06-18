###############################################################################
# fzf
#
# fzf is a general-purpose command-line fuzzy finder.
#
# https://github.com/junegunn/fzf
#
# File locations:
# - ~/.fzf
# - ~/.fzf.bash
# - ~/.fzf.zsh
# - ~/.profile.d/fzf.sh
###############################################################################

if [ -n "$ZSH_VERSION" ]; then
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
elif [ -n "$BASH_VERSION" ]; then
  [ -f ~/.fzf.bash ] && source ~/.fzf.bash
fi
