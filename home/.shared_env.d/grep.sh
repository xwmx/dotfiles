###############################################################################
# Grep
###############################################################################

# Use color by default
if echo "hello" | grep --color=auto l >/dev/null 2>&1
then
  export GREP_COLOR='1;32'

  alias grep="grep --color=auto"
  alias fgrep="fgrep --color=auto"
  alias egrep="egrep --color=auto"
fi
