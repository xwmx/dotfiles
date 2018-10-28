###############################################################################
# rbenv
#
# Simple Ruby version management
#
# https://github.com/sstephenson/rbenv
###############################################################################

###############################################################################
# Lazy load rbenv.
#
# rbenv loading can be slow, so defer loading until one of the ruby functions
# is called.

# __enable_rbenv()
#
# Usage:
#   __enable_rbenv
#
# Description:
#   Initialize rbenv and $PATH for bin directory.
__enable_rbenv() {
  export PATH="${HOME}/.rbenv/bin:${PATH}"

  if which rbenv > /dev/null
  then
    # Don't enable rbenv on Ubuntu, since RVM is currently preferred there.
    if [[ ! "$(uname -a)" =~ Ubuntu ]]
    then
      eval "$(rbenv init -)"
    fi
  fi
}

export __RBENV_ENABLED=0

gem() {
  unset -f gem
  __enable_rbenv
  __RBENV_ENABLED=1
  gem "$@"
}

irb() {
  unset -f irb
  __enable_rbenv
  __RBENV_ENABLED=1
  irb "$@"
}

rbenv() {
  unset -f rbenv
  __enable_rbenv
  __RBENV_ENABLED=1
  rbenv "$@"
}

ruby() {
  unset -f ruby
  __enable_rbenv
  __RBENV_ENABLED=1
  ruby "$@"
}
