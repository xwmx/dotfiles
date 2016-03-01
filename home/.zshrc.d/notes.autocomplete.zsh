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

  if [[ "${?}" -eq 0 ]]
  then
    compadd -- "${_commands[@]}"
    return 0
  else
    return 1
  fi
}

compdef _notes_subcommands notes
