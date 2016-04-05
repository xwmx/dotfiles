###############################################################################
# rbenv
#
# Simple Ruby version management
#
# https://github.com/sstephenson/rbenv
###############################################################################

# _enable_rbenv()
#
# Usage:
#   _enable_rbenv
#
# Description:
#   Initialize rbenv and $PATH for bin directory.
_enable_rbenv() {
  export PATH="${HOME}/.rbenv/bin:${PATH}"

  if which rbenv > /dev/null
  then
    eval "$(rbenv init -)"
  fi
}

# Don't enable rbenv on Ubuntu, since RVM is currently preferred there.
if [[ ! "$(uname -a)" =~ Ubuntu ]]
then
  _enable_rbenv
fi
