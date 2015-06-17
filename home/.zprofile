###############################################################################
# .zprofile
#
# config for non-interactive and interactive instances. Zsh loads this after
# .zshenv and before .zshrc
#
# zsh startup sequence:
#
# .zshenv
# >> .zprofile
# .zshrc
# .zlogin
# .zlogout
#
# http://zsh.sourceforge.net/Intro/intro_3.html
###############################################################################

###############################################################################
# Verbose Init
###############################################################################

. "$HOME/.shared_verbose_init"
__verbose_init printf "Loading .zprofile\n"

###############################################################################
# Init
###############################################################################

# Load .profile if present.
if [[ -f "$HOME/.profile" ]]
then
  source "$HOME/.profile"
fi

###############################################################################
# Local .zprofile
###############################################################################

# Load local config if present
[[ -f ~/.zprofile.local ]] && source ~/.zprofile.local
