###############################################################################
# RVM
#
# Ruby Version Manager (RVM)
#
# RVM is a command-line tool which allows you to easily install, manage, and
# work with multiple ruby environments from interpreters to sets of gems.
#
# https://rvm.io/
###############################################################################

# _enable_rvm()
#
# Usage:
#   _enable_rvm
#
# Description:
#   Initialize RVM.
_enable_rvm() {
  if [[ -s "${HOME}/.rvm/scripts/rvm" ]]
  then
    source "${HOME}/.rvm/scripts/rvm"
  fi
}

# Only enable RVM on Ubuntu.
if [[ "$(uname -a)" =~ Ubuntu ]]
then
  _enable_rvm
fi
