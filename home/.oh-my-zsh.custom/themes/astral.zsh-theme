###############################################################################
# Astral
#
# A minor tweak of robbyrussell theme.
###############################################################################

# Prefix prompt with arrow with color indicating last return status: green
# for 0 and red for non-0.
local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ %s)"

# Display alternate machine prompt for remote sessions.
#
# Makes it easier to distinguish between local and remote sessions.
local session_status
if [[ "$SESSION_TYPE" == "remote/ssh" ]]
then
  session_status="%{$fg_bold[blue]%}⦙⧓ %{$fg_bold[yellow]%}ssh:%{$fg_bold[green]%}"
else
  session_status="%{$fg_bold[blue]%}"
fi

PROMPT='${ret_status}%{$fg_bold[green]%}%p ${session_status}%m:%{$fg[cyan]%}%2~ %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
