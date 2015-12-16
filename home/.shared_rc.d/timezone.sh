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
  Display and set the timezone for the system. Supports Linux and OS X.
HEREDOC
}

# timezone()
#
# Usage:
#   timezone
#   timezone set (pt | et | utc | <timezone>)
#   timezone help | -h | --help
timezone() {
  local _system_command
  if hash "timedatectl" 2>/dev/null
  then # Linux
    _system_command="timedatectl"
  elif hash "systemsetup" 2>/dev/null
  then # OS X
    _system_command="systemsetup"
  else
    printf "❌ Either \`timedatectl\` or \`systemsetup\` is required.\n"
    __print_timezone_usage
    return 1
  fi

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
        local _timezone_set_command

        case "$_system_command" in
          timedatectl)
            _timezone_set_command="sudo timedatectl set-timezone"
            ;;
          systemsetup)
            _timezone_set_command="sudo systemsetup -settimezone"
            ;;
        esac

        case "$_zone" in
          pt|PT)
            eval "$_timezone_set_command" America/Los_Angeles &&
              timezone
            ;;
          et|ET)
            eval "$_timezone_set_command" America/New_York &&
              timezone
            ;;
          utc|UTC)
            eval "$_timezone_set_command" UTC &&
              timezone
            ;;
          *)
            eval "$_timezone_set_command" "$_zone" &&
              timezone
            ;;
        esac
      fi
      ;;
    list)
      case "$_system_command" in
        timedatectl)
          timedatectl list-timezones | less
          ;;
        systemsetup)
          sudo systemsetup -listtimezones | less
          ;;
      esac
      ;;
    pt)
      timezone 'set' PT
      ;;
    et)
      timezone 'set' ET
      ;;
    *)
      case "$_system_command" in
        timedatectl)
          timedatectl | grep Time\ zone | awk '{$1 = ""; $2 = ""; print $0 }'
          ;;
        systemsetup)
          sudo systemsetup -gettimezone | awk '{$1 = ""; $2 = ""; print $0 }'
          ;;
      esac
      ;;
  esac
}
