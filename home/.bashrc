###############################################################################
# .bashrc
#
# More info about OS X shell startup:
# http://hayne.net/MacDev/Notes/unixFAQ.html#shellStartup
###############################################################################

###############################################################################
# Verbose Init
###############################################################################

. "$HOME/.shared_verbose_init"
__verbose_init printf "Loading .bashrc\n"

###############################################################################
# .bashenv
###############################################################################

# source .bashenv
#
# Unlike zsh, this file is not known to bash, so it needs an explicit invites.
source "$HOME/.bashenv"

###############################################################################
# .profile
###############################################################################

# source .profile
#
# Because .bash_profile is present, .profile isn't sourced during bash
# startup. In the current configuration, .bash_profile simply sourced .bashrc,
# so .profile is sourced here and will be automatically included in
# .bash_profile
source "$HOME/.profile"

###############################################################################
# Init
###############################################################################

source "$HOME/.shared_rc"

# Source all files in ".bashrc.d"
init_src .bashrc.d

###############################################################################
# Local config
###############################################################################

# Load local config if present
[[ -f ~/.bashrc.local ]] && source ~/.bashrc.local
