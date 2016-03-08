###############################################################################
# Astral
#
# Prompt reference:
# http://www.nparikh.org/unix/prompt.php
# http://bolyai.cs.elte.hu/zsh-manual/zsh_15.html
#
# See also:
# https://github.com/caiogondim/bullet-train-oh-my-zsh-theme
###############################################################################

###############################################################################
# Hooks
###############################################################################

# $ASTRAL_COMMAND_START_TIME
#
# The start time value before each command is executed.
export ASTRAL_COMMAND_START_TIME
preexec() {
  ASTRAL_COMMAND_START_TIME="$(date +%s)"
}
precmd() {
  _COMMAND_START_TIME="${ASTRAL_COMMAND_START_TIME:-}"
  ASTRAL_COMMAND_START_TIME=""
}

###############################################################################
# Helpers
###############################################################################

# _astral_spaces()
#
# Usage:
#   _astral_line [<length>]
#
# Description:
#   Print a line of spaces <length> columns long, defauling to `$COLUMNS`.
_astral_spaces() {
  local _length="${1:-${COLUMNS}}"
  printf '%*s' "${_length}"
}

# _astral_visible_length()
#
# Usage:
#   _astral_visible_length <string>
#
# Description:
#   Print the visible length of a string.
#
# References:
#   http://stackoverflow.com/a/10564427
_astral_visible_length() {
  local _string="${1:-}"
  local _zero='%([BSUbfksu]|([FBK]|){*})'
  local _length=${#${(S%%)_string//$~_zero/}}
  printf "%s\n" "${_length}"
}

###############################################################################
# Components
###############################################################################

# _command
###############################################################################

# _astral_command_prompt()
#
# Usage:
#   _astral_command_prompt
#
# Description:
#   Display a row of color '❯' characters. Use last return status to display
#   green to blue gradient if the last command returned with a 0 and red to
#   blue if it returned with a non-zero status.
_astral_command_prompt() {
  local _prompt_0=""
  for __color in green yellow cyan blue
  do
    _prompt_0="${_prompt_0}%{$fg_bold[${__color}]%}❯"
  done

  local _prompt_non_0=""
  for __color in red magenta blue cyan
  do
    _prompt_non_0="${_prompt_non_0}%{$fg_bold[${__color}]%}❯"
  done

  printf "%s\n" "%(?:${_prompt_0}:${_prompt_non_0}%s)"
}

# _git
###############################################################################

# _astral_git_prompt()
#
# Usage:
#   _astral_git_prompt
#
# Description:
#   Generate the git prompt.
#
#   Reimplements some functions here:
#     https://github.com/robbyrussell/oh-my-zsh/blob/master/lib/git.zsh
#
# See also:
# https://news.ycombinator.com/item?id=10121997
# https://github.com/yonchu/zsh-vcs-prompt
# https://github.com/arialdomartini/oh-my-git
# https://github.com/michaeldfallen/git-radar
_astral_git_prompt() {
  # `git_prompt_info` variables
  local _prompt_prefix="git:%{$fg[cyan]%}"
  local _prompt_suffix="%{${reset_color}%}"
  local _prompt_dirty="%{$fg[blue]%} %{$fg[yellow]%}✕%{${reset_color}%}"
  local _prompt_clean="%{$fg[blue]%}"

  _parse_git_dirty() {
    local STATUS=''
    local FLAGS
    FLAGS=('--porcelain')
    if [[ "$(command git config --get oh-my-zsh.hide-dirty)" != "1" ]]
    then
      if [[ ${POST_1_7_2_GIT} -gt 0 ]]
      then
        FLAGS+='--ignore-submodules=dirty'
      fi
      if [[ "${DISABLE_UNTRACKED_FILES_DIRTY}" = "true" ]]
      then
        FLAGS+='--untracked-files=no'
      fi
      STATUS=$(command git status ${FLAGS} 2> /dev/null | tail -n1)
    fi
    if [[ -n ${STATUS} ]]
    then
      printf "%s\n" "${_prompt_dirty}"
    else
      printf "%s\n" "${_prompt_clean}"
    fi
  }

  _git_prompt_info() {
    local _ref
    if [[ "$(command git config --get oh-my-zsh.hide-status 2>/dev/null)" != "1" ]]
    then
      _ref=$(command git symbolic-ref HEAD 2> /dev/null) \
        || _ref=$(command git rev-parse --short HEAD 2> /dev/null) \
        || return 0
      printf "%s\n" "${_prompt_prefix}${_ref#refs/heads/}$(_parse_git_dirty)${_prompt_suffix}"
    fi
  }

  # For now, just fall back to the `git_prompt_info`oh-my-zsh shell function.
  local _raw_git_prompt
  _raw_git_prompt="$(_git_prompt_info)"
  if [[ -n "${_raw_git_prompt}" ]]
  then
    printf "%s\n" "%{$fg_bold[blue]%}${_raw_git_prompt}%{$fg_bold[blue]%}"
  else
    printf ""
  fi
}

# _machine
###############################################################################

# _astral_machine()
#
# Usage:
#   _astral_machine
#
# Description:
#   Display alternate machine prompt for remote sessions.
#
#   This makes it easier to distinguish between local and remote sessions.
_astral_machine() {
  local _astral_machine_string
  if [[ "${SESSION_TYPE}" == "remote/ssh" ]]
  then
    local _astral_ssh_prefix="%{$fg_bold[blue]%}⦙⧓ %{$fg_bold[yellow]%}ssh:"
    _astral_machine_string="${_astral_ssh_prefix}%{$fg_bold[green]%}%n@%m"
  else
    _astral_machine_string="%{$fg_bold[blue]%}%m"
  fi
  printf "%s\n" "${_astral_machine_string}"
}

# _rbenv
###############################################################################

# _astral_rbenv_prompt()
#
# Usage:
#   _astral_rbenv_prompt
#
# Description:
#   If rbenv is installed and _rbenv_version_status() returns a version,
#   generate the prompt section displaying the Ruby version.
_astral_rbenv_prompt() {
  if hash "rbenv" &> /dev/null
  then
    local _maybe_rbenv_version
    _maybe_rbenv_version="$(_astral_rbenv_version_status)"
    if [[ -n "${_maybe_rbenv_version}" ]]
    then
      local _rbenv_prefix="%{$fg_bold[blue]%}ruby:"
      local _rbenv_value="%{$fg_bold[cyan]%}${_maybe_rbenv_version}"
      local _rbenv_suffix="%{$fg_bold[blue]%}%{${reset_color}%} "
      local _rbenv_string="${_rbenv_prefix}${_rbenv_value}${_rbenv_suffix}"
    else
      _rbenv_string=""
    fi
    printf "%s\n" "${_rbenv_string}"
  fi
}

# _rbenv_version_status()
#
# Usage:
#   _rbenv_version_status
#
# Description:
#   show current rbenv version if different from rbenv global
#
# via: https://gist.github.com/mislav/1712320
_astral_rbenv_version_status() {
  local _version
  _version="$(rbenv version-name)"
  if [[ "$(rbenv global)" != "${_version}" ]]
  then
    printf "%s\n" "${_version}"
  fi
}

###############################################################################
# Lines
###############################################################################

# _context_line
###############################################################################

# _context_line()
#
# Usage:
#   _context_line
#
# Description:
#   Print the context line.
_context_line() {
  # $_path
  #
  # Show the first two current path segments, with a ~ for the home
  # directory.
  local _path
  _path="%{$fg[cyan]%}%2~"

  # $_context
  #
  # machine:~/path
  # ssh:machine:~/path
  local _context
  _context="$(_astral_machine):${_path}"

  # $_full_line
  #
  # Full prompt line.
  local _full_line
  _full_line="${_context} $(_astral_rbenv_prompt)$(_astral_git_prompt)"

  printf "%s\n" "${_full_line}%{${reset_color}%}"
}

# _prompt_line
###############################################################################

# _prompt_line()
#
# Usage:
#   _prompt_line
#
# Description:
#   Print the prompt line.
_prompt_line() {
  printf "%s\n" "$(_astral_command_prompt) %{${reset_color}%}"
}

# _return_line
###############################################################################

# _return_line()
#
# Usage:
#   _return_line
#
# Description:
#   Print the return line.
_return_line() {
  # $_current_timestamp
  local _current_timestamp="$(date +%s)"

  # $_duration
  local _duration
  if [[ -n "${_COMMAND_START_TIME}" ]]
  then
    _duration="$((_current_timestamp - _COMMAND_START_TIME))s"
  else
    _duration=""
  fi

  # $_time
  #
  # The current time in 24-hour format.
  local _time
  _time="%* %D{%F}"

  # $_return_status_0
  #
  # The prefix when the previous command returns with status 0.
  #
  # NOTE: Character options:
  # - ❤︎
  # - •
  # NOTE: Unicode characters cause tab completion to delete previous command's
  # output lines.
  local _return_status_0
  _return_status_0="%{$fg_no_bold[black]%}•"

  # $_return_status_1
  #
  # The prefix when the previous command returns with status 1.
  #
  # NOTE: Character options:
  # - ✖︎
  # - x
  # NOTE: Unicode characters cause tab completion to delete previous command's
  # output lines.
  local _return_status_1
  _return_status_1="%{$fg_no_bold[red]%}x"

  # $_return_status
  #
  # Prefix prompt with a symbol with color indicating last return status:
  # green for 0 and red for non-0.
  local _return_status
  _return_status="%(?:${_return_status_0}:${_return_status_1})"

  # $_prefix
  local _prefix
  _prefix="${_return_status} ${_duration}"

  # $_prefix_visible_length
  local _prefix_visible_length
  _prefix_visible_length="$(_astral_visible_length "${_prefix}")"

  # $_spacer_length
  local _spacer_length
  _spacer_length="$((COLUMNS - _prefix_visible_length - 21))"

  # $_spacer
  #
  # A string of characters for spacing elements.
  local _spacer
  _spacer="$(_astral_spaces "${_spacer_length}" | tr ' ' '⋅')"

  # $_full_line
  local _full_line
  _full_line="${_prefix} ${_spacer} ${_time}"

  printf "%s\n" "${_full_line}%{${reset_color}%}"
}

###############################################################################
# Prompt
###############################################################################

export ASTRAL_DISPLAY_CONTEXT=1
astral() {
  export _NEWLINE=$'\n'

  if [[ "${1:-}" =~ '^-h|--help|help$' ]]
  then
    cat <<HEREDOC
Usage:
  astral (hide | show | prompt)
  yes -h | --help

Options:
  -h --help  Display this usage information.

Subcommands:
  hide    Hide the top section.
  show    Show the top section.
  prompt  Print the formatted prompt string to assign to \$PROMPT.

Description:
  A ZSH theme.
HEREDOC
    return 0
  elif [[ "${1:-}" =~ '^off|hide|disable|simple$' ]]
  then
    ASTRAL_DISPLAY_CONTEXT=0
  elif [[ "${1:-}" =~ '^on|show|enable|normal$' ]]
  then
    ASTRAL_DISPLAY_CONTEXT=1
  elif  [[ "${1:-}" =~ '^prompt$' ]]
  then
    # $_top_section
    #
    # Full top section.
    local _top_section
    _top_section="$(_return_line)${_NEWLINE}$(_context_line)"

    # $_bottom_line
    #
    # Full bottom prompt line.
    local _bottom_line
    _bottom_line="$(_astral_command_prompt) %{${reset_color}%}"

    if ((ASTRAL_DISPLAY_CONTEXT))
    then
      printf "%s\n" "${_top_section}${_NEWLINE}${_bottom_line}"
    else
      printf "%s\n" "${_bottom_line}"
    fi
  else
    "${0}" -h
  fi
}

# $PROMPT
#
# Primary prompt variable. Use $RPROMPT to put a prompt on the right side.
PROMPT=$'$(astral prompt)'
