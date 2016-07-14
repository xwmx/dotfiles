
# hr()
#
# Usage:
#   hr
#
# Description:
#   Print a horizontal line with a length matching the width of the terminal.
hr() {
  printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
}
