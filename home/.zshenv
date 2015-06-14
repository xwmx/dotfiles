###############################################################################
# .zshenv
#
# config for non-interactive and interactive instances. Zsh loads this before
# loading .zshrc
###############################################################################

###############################################################################
# Init
###############################################################################

# Load environment if it hasn't already been.
if [[ ! $SHARED_ENV_LOADED == true ]]
then
  source "$HOME/.shared_env"
fi

# Source everything in .zshenv.d if it's present. `init_src` is defined in
# $HOME/.shared_env
if [[ -d "$HOME/.zshenv.d" ]]
then
  init_src .zshenv.d
fi

# load .zshenv.local if it exists
if [[ -f "$HOME/.zshenv.local" ]]
then
  source "$HOME/.zshenv.local"
fi


# NOTE: any config that can be shared with other shells should be added to
# .shared_env or .shared_env.d
