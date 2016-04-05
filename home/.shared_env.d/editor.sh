###############################################################################
# Editor
###############################################################################

if [[ -n "${SSH_CONNECTION}" ]]
then
  export EDITOR='vim'
else
  # export EDITOR='mvim'
  export EDITOR='vim'
fi

###############################################################################
# Vim
###############################################################################

# Directory containing MacVim.app
export VIM_APP_DIR="/Applications"
