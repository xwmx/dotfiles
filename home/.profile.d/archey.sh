###############################################################################
# archey-osx
#
# An archey script clone for OS X
#
# Displays system information and a colorful Apple logo.
#
# https://obihann.github.io/archey-osx/
# https://github.com/obihann/archey-osx
#
# See also:
# https://github.com/djmelik/archey
###############################################################################

# Use `archey` to display system information on login if it's in the $PATH.
if program_exists "archey"
then
  archey -c
fi
