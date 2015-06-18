###############################################################################
# .bashrc
#
# In the current configuration, .bashrc is used as the primary bash startup
# file. Some version of bash on some systems load either .bash_profile or
# .bashrc dependending on the type of session. In order to eliminate
# confusion, all bash startup commands are placed here in .bashrc, and
# .bashrc is then sourced in .bash_profile.
#
# In order to better share settings between zsh and bash, the zsh startup
# sequence is emulated here by first loading a .bashenv startup file,
# then .profile (which is treated as a shared .profile), followed by the
# various *rc files.
#
# More info about OS X shell startup:
# http://hayne.net/MacDev/Notes/unixFAQ.html#shellStartup
#
# See also: http://wp.me/p1JkE-6S (shreevatsa.wordpress.com)
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
if [[ -f "$HOME/.bashenv" ]]
then
  source "$HOME/.bashenv"
fi

###############################################################################
# .profile
###############################################################################

# source .profile
#
# Because .bash_profile is present, .profile isn't sourced during bash
# startup. In the current configuration, .bash_profile simply sourced .bashrc,
# so .profile is sourced here and will be automatically included in
# .bash_profile
if [[ -f "$HOME/.profile" ]]
then
  source "$HOME/.profile"
fi

###############################################################################
# .shared_rc
###############################################################################

# Load .shared_rc if present.
if [[ -f "$HOME/.shared_rc" ]]
then
  source "$HOME/.shared_rc"
fi

###############################################################################
# .bashrc.d
###############################################################################

# Source all files in ".bashrc.d" if it's present. `init_src` is defined in
# $HOME/.shared_env
if [[ -d "$HOME/.bashrc.d" ]]
then
  init_src .bashrc.d
fi

###############################################################################
# Local config
###############################################################################

# Load local config if present
if [[ -f "$HOME/.bashrc.local" ]]
then
  source "$HOME/.bashrc.local"
fi
