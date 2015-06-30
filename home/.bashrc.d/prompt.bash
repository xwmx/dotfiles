###############################################################################
# Shell prompt settings.
#
# Display the working directory in the prompt, truncated with a leading "..."
# when it reaches the character limit. Preseve ~ when in home directory.
# host:~/dirname user$ if ab_path_minus_Users/username < char limit
# host:up_to_23_chars_of_ab_path_minus_Users/username user$ if > char limit
# without color: '\h:\w \u$ '
# http://tldp.org/HOWTO/Bash-Prompt-HOWTO/
###############################################################################

trim_prompt_path() {
  echo -n "$PWD" | sed -e "s/.*\(.\{$1\}\)/\1/"
}

pwd_path_length() {
  echo -n "$PWD" | wc -c | tr -d " "
}

pwd_user_path_length() {
  echo -n "$PWD" | egrep -o /Users/"$(id -un)" | wc -c | tr -d " "
}

build_prompt_path() {

  local path_colors=$1
  local ps1_truncation=$2
  local ps1_pwd_path=""

  local total_path_length=$(pwd_path_length)
  local user_path_length=$(pwd_user_path_length)
  let home_pwd_length=$total_path_length-$user_path_length;

  # Maximum number of characters from the $PWD that should be kept.
  local max_pwd_length=23

  if [[ "$total_path_length" -lt "$max_pwd_length" ]]
  then
    # Path is shorter than max.
    # Example:
    # - /bin/
    ps1_pwd_path="$path_colors\w"
  elif [[ $user_path_length -gt 0 && $home_pwd_length -gt $max_pwd_length ]]
  then
    # In home, $PWD minus $HOME is longer than max.
    # Example:
    # - /Users/name/Library/Application Support
    # Becomes:
    # - ~...brary/Application Support
    new_pwd=$(trim_prompt_path $max_pwd_length)
    ps1_pwd_path="$path_colors~$ps1_truncation$path_colors$new_pwd"
  elif [[ "$user_path_length" -gt 0 ]]
  then
    # in home, $PWD minus $HOME is less than max, but $PWD is longer than max.
    # Example:
    # - /Users/name/Library
    # Becomes:
    # - ~/Library
    new_pwd=$(trim_prompt_path $home_pwd_length)
    ps1_pwd_path="$path_colors~/$new_pwd"
  else
    # Not in home and $PWD is longer than max.
    # Example:
    # - /usr/local/lib/ocaml/ocamldoc
    # Becomes:
    # - ...ocal/lib/ocaml/ocamldoc
    new_pwd=$(trim_prompt_path $max_pwd_length)
    ps1_pwd_path="$ps1_truncation$path_colors$new_pwd"
  fi

  echo "$ps1_pwd_path"
}


prompt_command() {

  # tput reference
  #
  # tput colors:
  #
  # 0 - black
  # 1 - red
  # 2 - green
  # 3 - yello
  # 4 - blue
  # 5 - magenta
  # 6 - cyan
  # 7 - white
  #
  # tput text modes:
  #
  # bold  – Set bold mode
  # dim   – turn on half-bright mode
  # smul  – begin underline mode
  # rmul  – exit underline mode
  # rev   – Turn on reverse mode
  # smso  – Enter standout mode (bold on rxvt)
  # rmso  – Exit standout mode
  # sgr0  – Turn off all attributes
  #
  # tput color settings
  #
  # setab [1-7]   – Set a background color using ANSI escape
  # setb [1-7]    – Set a background color
  # setaf [1-7]   – Set a foreground color using ANSI escape
  # setf [1-7]    – Set a foreground color
  #
  # Example:
  # export PS1="\[$(tput bold)$(tput setb 4)$(tput setaf 7)\]\u@\h:\w $ \[$(tput sgr0)\]“

  # magenta bg, black fg
  local ps1_prefix="\[$(tput setab 5)$(tput setaf 0)\] "
  # blue bg, black fg
  local ps1_user="\[$(tput setab 4)$(tput setaf 0)\]\u"
  # black bg, green fg
  local ps1_at="\[$(tput setab 0)$(tput setaf 2)\]@"
  # black bg, blue fg
  local ps1_host="\[$(tput setab 0)$(tput setaf 4)\][\h]:"
  # black bg, red fg, underline
  local ps1_truncation="\[$(tput setab 0)$(tput setaf 1)$(tput smul)\]...\[$(tput rmul)\]"
  # black bg, green fg
  local ps1_prompt="\[$(tput setab 0)$(tput setaf 2)\]$"
  # black bg, white fg
  local ps1_suffix="\[$(tput setab 0)$(tput setaf 7)\] "
  # black bg, white fg
  local path_colors="\[$(tput setab 0)$(tput setaf 7)\]"

  # Primary sections
  local ps1_start="$ps1_prefix""$ps1_user""$ps1_at""$ps1_host"
  local ps1_pwd_path=$(build_prompt_path "$path_colors" "$ps1_truncation")
  local ps1_end=$(__git_ps1 " [git:%s]")\ "$ps1_prompt""$ps1_suffix"

  # Combined primary sections
  export PS1=$ps1_start$ps1_pwd_path$ps1_end
}


PROMPT_COMMAND=prompt_command
export PROMPT_COMMAND

