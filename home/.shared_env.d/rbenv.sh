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
