###############################################################################
# .profile
#
# This file is sourced by both .zprofile and .bashrc and is used to set common
# profile settings for both shells.
#
# Since the current configuration includes a .bash_profile, Bash sources that
# file rather than this one on startup. As a result, neither zsh nor bash
# source this file automatically, and it therefore acts as a shared startup
# file.
#
# More info about OS X shell startup:
# http://hayne.net/MacDev/Notes/unixFAQ.html#shellStartup
###############################################################################

###############################################################################
# Verbose Init
###############################################################################

. "$HOME/.shared_verbose_init"
__verbose_init printf "Loading .profile\n"

###############################################################################
# .shared_env
###############################################################################

# Load environment if it hasn't already been.
if [[ ! $SHARED_ENV_LOADED == true ]]
then
  source "$HOME/.shared_env"
fi

###############################################################################
# .shared_env
###############################################################################

# Source all files in ".profile.d" if present.
if [[ -d "$HOME/.profile.d" ]]
then
  init_src .profile.d
fi
