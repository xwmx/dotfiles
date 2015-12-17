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
  timezone set (pt | mt | ct | et | utc | <timezone>)
  timezone list
  timezone help | -h | --help

Subcommands:
  set   Set the system timezone to the given timezone.
  list  List available timezones.
  help  Display this help information.

Description:
  Display and set the timezone for the system. Supports Linux and OS X.
HEREDOC
}

# timezone()
#
# Usage:
#   timezone
#   timezone set (pt | mt | ct | et | utc | <timezone>)
#   timezone list
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
          mt|MT)
            eval "$_timezone_set_command" America/Denver &&
              timezone
            ;;
          ct|CT)
            eval "$_timezone_set_command" America/Chicago &&
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
    pt|PT|mt|MT|ct|CT|et|ET|utc|UTC)
      timezone 'set' "$_subcommand"
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

alias tz="timezone"
