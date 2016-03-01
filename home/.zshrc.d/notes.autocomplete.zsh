###############################################################################
# notes.autocomplete.zsh
#
# Resources:
# https://github.com/zsh-users/zsh-completions/blob/master/zsh-completions-howto.org
# http://zsh.sourceforge.net/FAQ/zshfaq04.html
# http://zsh.sourceforge.net/Doc/Release/Completion-System.html
# http://zsh.sourceforge.net/Doc/Release/Completion-Widgets.html
# http://zsh.sourceforge.net/Guide/zshguide06.html
# https://askql.wordpress.com/2011/01/11/zsh-writing-own-completion/
# http://wikimatze.de/writing-zsh-completion-for-padrino
###############################################################################

_notes_subcommands() {
  local _commands
  _commands=($(notes commands))
  local _notebooks
  _notebooks=($(notes notebooks --names))
  local _completions
  _completions=(${_commands[@]})

  # Construct <notebook>:<subcommand> completions.
  for __notebook in "${_notebooks[@]}"
  do
    for __command in "${_commands[@]}"
    do
      if [[ -n "${__notebook:-}" ]] && [[ -n "${__command}" ]]
      then
        _completions+=("${__notebook}:${__command}")
      fi
    done
  done

  if [[ "${?}" -eq 0 ]]
  then
    compadd -- "${_completions[@]}"
    return 0
  else
    return 1
  fi
}

compdef _notes_subcommands notes
