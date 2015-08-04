###############################################################################
# ssh.sh
#
# SSH shell settings.
#
# See also: $HOME/.ssh
###############################################################################

# Alias `ssh` to a function that combines the contents of `.ssh/config.d` and
# `.ssh/config` into a `.ssh/config-all` file that is then used as the config
# file for `ssh`.
#
# Leaving the .ssh/config file as the default file and compiling to
# `.ssh/config-all` makes it easier to alter or remove this functionality
# without needing to perform extensive editing on the `.ssh/config` file.
#
# More information: http://superuser.com/q/247564
_SSH_CMD="$(which ssh)"
ssh() {
  printf "\
###############################################################################
# This is a generated ssh config file that is created by a wrapper around the
# \`ssh\` command in order to combine multiple ssh config files.
#
# More information: ~/.shared_rc.d/ssh.sh
###############################################################################
" > ~/.ssh/config-all
  cat ~/.ssh/config.d/* >> ~/.ssh/config-all
  cat ~/.ssh/config >> ~/.ssh/config-all
  "$_SSH_CMD" -F ~/.ssh/config-all "$@"
}
