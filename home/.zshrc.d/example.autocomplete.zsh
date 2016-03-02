###############################################################################
# example.autocomplete.zsh
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

# _example_completions() {
#   local _completions=(one two three)
#
#   if [[ "${?}" -eq 0 ]]
#   then
#     compadd -- "${_completions[@]}"
#     return 0
#   else
#     return 1
#   fi
# }
#
# compdef _example_completions example
