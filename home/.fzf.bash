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

# Setup fzf
# ---------
if [[ ! "$PATH" =~ "$HOME"/.fzf/bin ]]; then
  export PATH="$PATH:$HOME/.fzf/bin"
fi

# Man path
# --------
if [[ ! "$MANPATH" =~ "$HOME"/.fzf/man && -d "$HOME/.fzf/man" ]]; then
  export MANPATH="$MANPATH:$HOME/.fzf/man"
fi

# Auto-completion
# ---------------
[[ $- =~ i ]] && source "$HOME/.fzf/shell/completion.bash"

# Key bindings
# ------------
source "$HOME/.fzf/shell/key-bindings.bash"

