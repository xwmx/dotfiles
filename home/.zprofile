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
# http://wp.me/p1JkE-6S (shreevatsa.wordpress.com)
###############################################################################

###############################################################################
# Verbose Init
###############################################################################

. "${HOME}/.shared_verbose_init"
__verbose_init printf "Loading .zprofile\n"

###############################################################################
# .profile
###############################################################################

# Load .profile if present.
if [[ -f "${HOME}/.profile" ]]
then
  source "${HOME}/.profile"
fi

###############################################################################
# .zprofile.d
###############################################################################

# Source everything in .zprofile.d if it's present.
if [[ -d "${HOME}/.zprofile.d" ]]
then
  source_dir "${HOME}/.zprofile.d"
fi

###############################################################################
# Local config
###############################################################################

# Load local config if present
if [[ -f "${HOME}/.zprofile.local" ]]
then
  source "${HOME}/.zprofile.local"
fi
