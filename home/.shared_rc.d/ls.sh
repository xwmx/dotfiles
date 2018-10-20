###############################################################################
# ls.sh
###############################################################################

# el
#
# Enhanced ls.
#
# Options:
#   -a      Include directory entries whose names begin with a dot (.).
#   -G      Enable colorized output.
#
# NOTE: Limit to macOS pending portability review.
if is_macos
then
  alias el="ls -aG"
fi

# ell
#
# Enhanced ls long.
#
# Options:
#   -a      Include directory entries whose names begin with a dot (.).
#   -e      Print the Access Control List (ACL) associated with the file, if present, in
#           long (-l) output.
#   -G      Enable colorized output.
#   -h      When used with the -l option, use unit suffixes: Byte, Kilobyte, Megabyte,
#           Gigabyte, Terabyte and Petabyte in order to reduce the number of digits to
#           three or less using base 2 for sizes.
#   -l      (The lowercase letter ``ell''.)  List in long format.  (See below.)  If the
#           output is to a terminal, a total sum for all the file sizes is output on a
#           line before the long listing.
#   -O      Include the file flags in a long (-l) output.
#   -@      Display extended attribute keys and sizes in long (-l) output.
#
# NOTE: Limit to macOS pending portability review.
if is_macos
then
  alias ell="ls -aeGhlO@"
fi

# ll
#
# General purpose ls.
#
# Options:
#   -a      Include directory entries whose names begin with a dot (.).
#   -h      When used with the -l option, use unit suffixes: Byte, Kilobyte, Megabyte,
#           Gigabyte, Terabyte and Petabyte in order to reduce the number of digits to
#           three or less using base 2 for sizes.
#   -l      (The lowercase letter ``ell''.)  List in long format.  (See below.)  If the
#           output is to a terminal, a total sum for all the file sizes is output on a
#           line before the long listing.
alias ll="ls -lah"
