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

# load .zshenv.local if it exists
if [[ -f "$HOME/.zshenv.local" ]]
then
  source "$HOME/.zshenv.local"
fi


# NOTE: any config that can be shared with other shells should be added to
# .shared_env or .shared_env.d
