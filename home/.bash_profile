###############################################################################
# .bash_profile
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
__verbose_init printf "Loading .bash_profile\n"

###############################################################################
# Source .bashrc
###############################################################################

# .bashrc is the preferred loaction for basic bash configuration commands, but
# this file is loaded for login sessions on some systems. Sourcing .bashrc
# here ensures that the settings are the same in both places.
#
# .profile is sourced in .bashrc, and will in turn be sourced here.
if [[ -f "$HOME/.bashrc" ]]
then
  source "$HOME/.bashrc"
fi
