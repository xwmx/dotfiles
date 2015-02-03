###############################################################################
# htop
#
# an interactive process viewer for Linux
#
# http://hisham.hm/htop/
#
# See also: $HOME/.htoprc
###############################################################################

# For htop to display correctly all running processes, it needs to run as root.
_original_htop="$(which htop)"
htop() {
  sudo "$_original_htop" "$@"
}
