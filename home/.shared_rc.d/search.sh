###############################################################################
# Search Aliases
#
# Aliases for the `search` command, found at ~/bin/search
###############################################################################

__search_cmd="$(which search)"
if [[ -n "${__search_cmd}" ]]
then
  google() {
    "${__search_cmd}" "google" "${@}"
  }

  ddg() {
    "${__search_cmd}" "ddg" "${@}"
  }

  spt() {
    "${__search_cmd}" "spotlight" "${@}"
  }
fi
