###############################################################################
# cmus
#
# cmus is a small, fast and powerful console music player for Unix-like
# operating systems.
#
# https://cmus.github.io
# https://news.ycombinator.com/item?id=10430512
###############################################################################

# Silence error messages on El Capitan
#
# On El Capitan, a "...deprecated Carbon Component Manager..." error message
# is displayed when a track is selected to play. More information:
# https://github.com/cmus/cmus/issues/331
if is_macos && is_el_capitan
then
  alias cmus="cmus 2> /dev/null"
fi
