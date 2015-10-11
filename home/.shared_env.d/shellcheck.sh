###############################################################################
# ShellCheck
#
# Automatically detects problems with sh/bash scripts and commands
#
# http://www.shellcheck.net//
###############################################################################

# TODO: implement this.
#
# # Wrap `shellcheck` command in a function that looks for a configuration
# # file containing rules to ignore when the command is run. For a simple
# # implementation, the rules could be listed on each line.
# #
# # More info: https://github.com/koalaman/shellcheck/wiki/Ignore
#
# _SHELLCHECK_CMD="$(which shellcheck)"
# shellcheck() {
#   if (file with shellehck rule disables is in this directory or any parent)
#   then
#     for each rule, add to the SHELLCHECK_OPTS variable:
#     export SHELLCHECK_OPTS="-e SC2059"
#   else
#     export SHELLCHECK_OPTS=""
#   fi
# }
