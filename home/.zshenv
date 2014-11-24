# .zshenv
#
# config for non-interactive and interactive instances. Zsh loads this before
# loading .zshrc

#==========================================================================
# Init
#==========================================================================

# Load environment if it hasn't already been.
if [[ ! $SHARED_ENV_LOADED == true ]]; then
  source "$HOME/.shared_env"
fi
