###############################################################################
# rbenv
#
# Simple Ruby version management
#
# https://github.com/sstephenson/rbenv
###############################################################################

export PATH="$HOME/.rbenv/bin:$PATH"

if which rbenv > /dev/null
then
  eval "$(rbenv init -)"
fi

if [ -n "$ZSH_VERSION" ]
then
  if which rbenv > /dev/null
  then
    eval "$(rbenv init - zsh)"
  fi
elif [ -n "$BASH_VERSION" ]
then
  if which rbenv > /dev/null
  then
    eval "$(rbenv init - bash)"
  fi
fi
