###############################################################################
# timezone.sh
#
# Set the system time zone.
###############################################################################

# __print_timezone_usage()
#
# Usage:
#   __print_timezone_usage
__print_timezone_usage() {
  cat <<HEREDOC
Usage:
  timezone
  timezone set (pt | et | utc | <timezone>)
  timezone help | -h | --help

Description:
  Display and set the timezone for the system. Requires \`timedatectl\`.
HEREDOC
}

# timezone()
#
# Usage:
#   timezone
#   timezone set (pt | et | utc | <timezone>)
#   timezone help | -h | --help
timezone() {
  if ! hash "timedatectl" 2>/dev/null
  then
    printf "❌ \`timedatectl\` not found on this system.\n"
    __print_timezone_usage
    return 1
  else
    local _subcommand="${1:-}"
    case $_subcommand in
      help|-h|--help)
        __print_timezone_usage
        ;;
      set)
        local _zone="${2:-}"
        if [[ -z "$_zone" ]]
        then
          __print_timezone_usage
          return 1
        else
          case "$_zone" in
            pt|PT)
              sudo timedatectl set-timezone America/Los_Angeles &&
                timezone
              ;;
            et|ET)
              sudo timedatectl set-timezone America/New_York &&
                timezone
              ;;
            utc|UTC)
              sudo timedatectl set-timezone UTC &&
                timezone
              ;;
            *)
              sudo timedatectl set-timezone "$_zone" &&
                timezone
              ;;
            esac
          fi
        ;;
      list)
        timedatectl list-timezones | less
        ;;
      *)
        timedatectl | grep Timezone | awk '{$1 = ""; print $0 }'
        ;;
    esac
  fi
}
