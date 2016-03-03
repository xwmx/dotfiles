###############################################################################
# Astral
#
# Based on the robbyrussell theme.
#
# Prompt reference:
# http://www.nparikh.org/unix/prompt.php
#
# See also:
# https://github.com/caiogondim/bullet-train-oh-my-zsh-theme
###############################################################################

# Basic Components
###############################################################################

# Prefix prompt with a symbol with color indicating last return status: green
# for 0 and red for non-0.
_ASTRAL_RETURN_STATUS="%(?:%{$fg_bold[green]%} ⧊ :%{$fg_bold[red]%} ⧂ %s)"

# The current time in 24-hour format.
#
# Will have same color as whatever preceeds it.
_ASTRAL_TIME="%T"

# _astral_machine()
#
# Display alternate machine prompt for remote sessions.
#
# Makes it easier to distinguish between local and remote sessions.
_astral_machine() {
  local _astral_machine_string
  if [[ "$SESSION_TYPE" == "remote/ssh" ]]
  then
    local _astral_ssh_prefix="%{$fg_bold[blue]%}⦙⧓ %{$fg_bold[yellow]%}ssh:"
    _astral_machine_string="${_astral_ssh_prefix}%{$fg_bold[green]%}%n@%m"
  else
    _astral_machine_string="%{$fg_bold[blue]%}%m"
  fi
  printf "%s\n" "${_astral_machine_string}"
}

# Show the first two current path segments, with a ~ for the home directory.
_ASTRAL_PATH="%{$fg[cyan]%}%2~"

# Parts
###############################################################################

# $_ASTRAL_PREFIX
#
# Combine return status, followed by time.
_ASTRAL_PREFIX="${_ASTRAL_RETURN_STATUS}${_ASTRAL_TIME}"

# $_ASTRAL_CONTEXT
#
# machine:~/path
# ssh:machine:~/path
_ASTRAL_CONTEXT="$(_astral_machine):${_ASTRAL_PATH}"

# rbenv
###############################################################################

# _rbenv_version_status()
#
# show current rbenv version if different from rbenv global
#
# via: https://gist.github.com/mislav/1712320
_astral_rbenv_version_status() {
  local _version="$(rbenv version-name)"
  if [[ "$(rbenv global)" != "${_version}" ]]
  then
    printf "%s\n" "${_version}"
  fi
}
# _astral_rbenv_prompt()
#
# If rbenv is installed and _rbenv_version_status() returns a version,
# generate the prompt section displaying the Ruby version.
_astral_rbenv_prompt() {
  local _maybe_rbenv_version
  local _rbenv_version_string
  if hash "rbenv" &> /dev/null
  then
    local _maybe_rbenv_version="$(_astral_rbenv_version_status)"
    if [[ -n "${_maybe_rbenv_version}" ]]
    then
      local _rbenv_prefix="%{$fg_bold[blue]%}ruby:"
      local _rbenv_value="%{$fg_bold[cyan]%}${_maybe_rbenv_version}"
      local _rbenv_suffix="%{$fg_bold[blue]%}%{${reset_color}%} "
      _rbenv_version_string="${_rbenv_prefix}${_rbenv_value}${_rbenv_suffix}"
    else
      _rbenv_version_string=""
    fi
    printf "%s\n" "${_rbenv_version_string}"
  fi
}

# git
###############################################################################

# _astral_git_prompt()
#
# Generate the git prompt.
#
# Reimplements some functions here:
# https://github.com/robbyrussell/oh-my-zsh/blob/master/lib/git.zsh
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
  local _prompt_dirty="%{$fg[blue]%} %{$fg[yellow]%}✗%{${reset_color}%}"
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

# Command Prompt
###############################################################################

# _astral_command_prompt
#
# Display a row of color '❯' characters. Use last return status to display
# green to blue gradient if the last command returned with a 0 and red to
# blue if it returned with a non-zero status.
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

# Prompt
###############################################################################

ASTRAL_DISPLAY_CONTEXT=1
astral() {
  export _NEWLINE=$'\n'

  if [[ "${1:-}" =~ '^-h|--help|help$' ]]
  then
    cat <<HEREDOC
Usage:
  astral (hide | prompt)
  yes -h | --help

Options:
  -h --help  Display this usage information.

Subcommands:
  hide    Hide top line.
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
    local _top_prefix
    _top_prefix="${_ASTRAL_PREFIX} ${_ASTRAL_CONTEXT}"

    local _top_line
    _top_line="${_top_prefix} $(_astral_rbenv_prompt)$(_astral_git_prompt)"

    local _bottom_line
    _bottom_line="$(_astral_command_prompt) %{$reset_color%}"

    if ((ASTRAL_DISPLAY_CONTEXT))
    then
      printf "%s\n" "${_top_line}${_NEWLINE}${_bottom_line}"
    else
      printf "%s\n" "${_bottom_line}"
    fi
  else
    "${0}" -h
  fi
}

# PROMPT
#
# Primary prompt variable. Use $RPROMPT to put a prompt on the right side.
PROMPT=$'$(astral prompt)'
