###############################################################################
# rm.sh
###############################################################################

# rm
#
# Override default `rm` to enforce a prompt to avoid accidental deletions.
#
# Options:
#   -i  Request confirmation before attempting to remove each file, regardless
#       of the file's permissions, or whether or not the standard input device
#       is a terminal.  The -i option overrides any previous -f options.
alias rm="rm -i"
