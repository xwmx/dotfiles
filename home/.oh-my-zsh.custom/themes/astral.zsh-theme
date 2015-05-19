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
local _astral_return_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ %s)"

# The current time in 24-hour format.
#
# Will have same color at whatever preceeds it.
local _astral_time="%T"

# Display alternate machine prompt for remote sessions.
#
# Makes it easier to distinguish between local and remote sessions.
local _astral_machine
if [[ "$SESSION_TYPE" == "remote/ssh" ]]
then
  _astral_machine="%{$fg_bold[blue]%}⦙⧓ %{$fg_bold[yellow]%}ssh:%{$fg_bold[green]%}%m"
else
  _astral_machine="%{$fg_bold[blue]%}%m"
fi

# Show the first two current path segments, with a ~ for the home directory.
local _astral_path="%{$fg[cyan]%}%2~"

# Parts
###############################################################################

# _prefix
#
# Combine return status, followed by time.
local _astral_prefix="${_astral_return_status}${_astral_time}"

# _context
#
# machine:~/path
# ssh:machine:~/path
local _astral_context="${_astral_machine}:${_astral_path}"

# Contruct
###############################################################################

PROMPT='${_astral_prefix} ${_astral_context} %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}'

# `git_prompt_info` variabled
###############################################################################

ZSH_THEME_GIT_PROMPT_PREFIX="git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
