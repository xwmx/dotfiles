###############################################################################
# .bashrc
#
# More info about OS X shell startup:
# http://hayne.net/MacDev/Notes/unixFAQ.html#shellStartup
###############################################################################

# load bashenv
# Unlike zsh, this is not a file known to bash, so it needs an explicit invite.
source "$HOME/.bashenv"
source "$HOME/.profile"

###############################################################################
# Init
###############################################################################

# Source all files in ".bashrc.d"
init_src .bashrc.d

###############################################################################
# Local config
###############################################################################

# Load local config if present
[[ -f ~/.bashrc.local ]] && source ~/.bashrc.local
