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
_astral_return_status="%(?:%{$fg_bold[green]%} ⧊ :%{$fg_bold[red]%} ⧂ %s)"

# The current time in 24-hour format.
#
# Will have same color as whatever preceeds it.
_astral_time="%T"

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
_astral_path="%{$fg[cyan]%}%2~"

# Parts
###############################################################################

# _prefix
#
# Combine return status, followed by time.
_astral_prefix="${_astral_return_status}${_astral_time}"

# _context
#
# machine:~/path
# ssh:machine:~/path
_astral_context="$(_astral_machine):${_astral_path}"

# rbenv
###############################################################################

# _rbenv_version_status()
#
# show current rbenv version if different from rbenv global
#
# via: https://gist.github.com/mislav/1712320
_astral_rbenv_version_status() {
  local ver=$(rbenv version-name)
  [ "$(rbenv global)" != "$ver" ] && echo "$ver"
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
    if [[ -n "$_maybe_rbenv_version" ]]
    then
      local _rbenv_prefix="%{$fg_bold[blue]%}ruby:"
      local _rbenv_value="%{$fg_bold[cyan]%}${_maybe_rbenv_version}"
      local _rbenv_suffix="%{$fg_bold[blue]%}%{$reset_color%} "
      _rbenv_version_string="${_rbenv_prefix}${_rbenv_value}${_rbenv_suffix}"
    else
      _rbenv_version_string=""
    fi
    printf "%s\n" "$_rbenv_version_string"
  fi
}

# git
###############################################################################

# `git_prompt_info` variables
ZSH_THEME_GIT_PROMPT_PREFIX="git:%{$fg[cyan]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%} %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%}"

# _astral_git_prompt()
#
# Generate the git prompt.
#
# See also:
# https://news.ycombinator.com/item?id=10121997
# https://github.com/yonchu/zsh-vcs-prompt
# https://github.com/arialdomartini/oh-my-git
# https://github.com/michaeldfallen/git-radar
_astral_git_prompt() {
  # For now, just fall back to the `git_prompt_info`oh-my-zsh shell function.
  local _git_prompt_info="$(git_prompt_info)"
  if [[ -n "$_git_prompt_info" ]]
  then
    printf "%s\n" "%{$fg_bold[blue]%}${_git_prompt_info}%{$fg_bold[blue]%}"
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
  for color in green yellow cyan blue
  do
    _prompt_0="$_prompt_0%{$fg_bold[$color]%}❯"
  done

  local _prompt_non_0=""
  for color in red magenta blue cyan
  do
    _prompt_non_0="$_prompt_non_0%{$fg_bold[$color]%}❯"
  done

  printf "%s\n" "%(?:${_prompt_0}:${_prompt_non_0}%s)"
}

# Prompt
###############################################################################

ASTRAL_NEWLINE=$'\n'

# _astral_top_prefix
#
# The top line, before any contextual data functions.
_astral_top_prefix="${_astral_prefix} ${_astral_context}"

# _astral_bottom_line
#
# The bottom line.
_astral_bottom_line="$(_astral_command_prompt) %{$reset_color%}"

ASTRAL_DISPLAY_CONTEXT=1
astral() {
  if [[ "${1:-}" =~ '^off|hide|disable|simple$' ]]
  then
    ASTRAL_DISPLAY_CONTEXT=0
  else
    ASTRAL_DISPLAY_CONTEXT=1
  fi
}

_astral_prompt() {
  if ((ASTRAL_DISPLAY_CONTEXT))
  then
    printf "%s\n" "${_astral_top_prefix} $(_astral_rbenv_prompt)$(_astral_git_prompt)${ASTRAL_NEWLINE}${_astral_bottom_line}"
  else
    printf "%s\n" "${_astral_bottom_line}"
  fi
}

# PROMPT
#
# Primary prompt variable. Use $RPROMPT to put a prompt on the right side.
# PROMPT=$'${_astral_top_prefix} $(_astral_rbenv_prompt)$(_astral_git_prompt)\n${_astral_bottom_line}'
PROMPT=$'$(_astral_prompt)'
