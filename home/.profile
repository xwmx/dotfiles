# .profile
#
# This file is sourced by both .zshrc and .bashrc and is used to set common
# rc and profile settings for both shells.
#
# More info about OS X shell startup:
# http://hayne.net/MacDev/Notes/unixFAQ.html#shellStartup


#==========================================================================
# Init
#==========================================================================

# Load environment if it hasn't already been.
if [[ ! $SHARED_ENV_LOADED == true ]]; then
  source "$HOME/.shared_env"
fi


# Source all files in ".profile.d"
init_src .profile.d
