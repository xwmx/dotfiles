###############################################################################
# Z
#
# Tracks your most used directories, based on 'frecency'.
#
# After  a  short  learning  phase, z will take you to the most 'frecent'
# directory that matches ALL of the regexes given on the command line, in
# order.
#
# For example, z foo bar would match /foo/bar but not /bar/foo.
#
# https://github.com/rupa/z/
#
# Expects installation via homebrew
################################################################################


if command_exists "brew"
then
  __BREW_PREFIX="$(brew --prefix)"
  if [ -f "${__BREW_PREFIX}/etc/profile.d/z.sh" ]
  then
    . "${__BREW_PREFIX}/etc/profile.d/z.sh"
  fi
fi
