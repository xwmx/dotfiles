###############################################################################
# Astral
#
# Based on the robbyrussell theme.
#
# Prompt reference:
# http://www.nparikh.org/unix/prompt.php
###############################################################################

# Basic Components
###############################################################################

# Prefix prompt with arrow with color indicating last return status: green
# for 0 and red for non-0.
_astral_return_status="%(?:%{$fg_bold[green]%}:%{$fg_bold[red]%}%s)"

# The current time in 24-hour format.
#
# Will have same color as whatever preceeds it.
_astral_time="%T"

# Display alternate machine prompt for remote sessions.
#
# Makes it easier to distinguish between local and remote sessions.
if [[ "$SESSION_TYPE" == "remote/ssh" ]]
then
  _astral_machine="%{$fg_bold[blue]%}⦙⧓ %{$fg_bold[yellow]%}ssh:%{$fg_bold[green]%}%n@%m"
else
  _astral_machine="%{$fg_bold[blue]%}%m"
fi

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
_astral_context="${_astral_machine}:${_astral_path}"

# _rbenv_version_status()
#
# show current rbenv version if different from rbenv global
#
# via: https://gist.github.com/mislav/1712320
_rbenv_version_status() {
  local ver=$(rbenv version-name)
  [ "$(rbenv global)" != "$ver" ] && echo "$ver"
}
# _rbenv_version_prompt()
#
# If rbenv is installed and _rbenv_version_status() returns a version,
# generate the prompt section displaying the Ruby version.
_rbenv_version_prompt() {
  local _maybe_rbenv_version
  local _rbenv_version_string
  if hash "rbenv" &> /dev/null
  then
    local _maybe_rbenv_version="$(_rbenv_version_status)"
    if [[ -n "$_maybe_rbenv_version" ]]
    then
      _rbenv_version_string="%{$fg_bold[blue]%}ruby:(%{$fg_bold[red]%}${_maybe_rbenv_version}%{$fg_bold[blue]%})%{$reset_color%} "
    else
      _rbenv_version_string=""
    fi
    printf "%s\n" "$_rbenv_version_string"
  fi
}

# git
###############################################################################

# `git_prompt_info` variables
ZSH_THEME_GIT_PROMPT_PREFIX="git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

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
  git_prompt_info
}

# Prompt
###############################################################################

PROMPT=$'${_astral_prefix} ${_astral_context} $(_rbenv_version_prompt)%{$fg_bold[blue]%}$(_astral_git_prompt)%{$fg_bold[blue]%} % %{$reset_color%}\n${_astral_return_status}➜ %{$reset_color%} '
