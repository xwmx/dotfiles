###############################################################################
# .zshenv
#
# config for non-interactive and interactive instances. Zsh loads this before
# loading .zshrc
#
# zsh startup sequence:
#
# >> .zshenv
# .zprofile
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

. "$HOME/.shared_verbose_init"
__verbose_init printf "Loading .zshenv\n"

###############################################################################
# .shared_env
###############################################################################

# Load environment if it hasn't already been.
if [[ ! $SHARED_ENV_LOADED == true ]]
then
  source "$HOME/.shared_env"
fi

###############################################################################
# .zshenv.d
###############################################################################

# Source everything in .zshenv.d if it's present. `init_src` is defined in
# $HOME/.shared_env
if [[ -d "$HOME/.zshenv.d" ]]
then
  init_src .zshenv.d
fi

###############################################################################
# Local config
###############################################################################

# load .zshenv.local if it exists
if [[ -f "$HOME/.zshenv.local" ]]
then
  source "$HOME/.zshenv.local"
fi


# NOTE: any config that can be shared with other shells should be added to
# .shared_env or .shared_env.d
