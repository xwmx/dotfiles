###############################################################################
# exa - shortcuts
#
# exa is a modern replacement for ls
#
# http://bsago.me/exa/
#
# Installation script:
#   $DOTFILES/install/scripts/orphans
#
# `exa --help` usage info, for reference:
#
# Usage:
#   exa [options] [files...]
#
# Options:
#     -1 --oneline        display one entry per line
#     -a --all            show dot-files
#     -b --binary         use binary prefixes in file sizes
#     -B --bytes          list file sizes in bytes, without prefixes
#     -d --list-dirs      list directories as regular files
#     -g --group          show group as well as user
#     -h --header         show a header row at the top
#     -H --links          show number of hard links
#     -i --inode          show each file's inode number
#     -l --long           display extended details and attributes
#     -m --modified       display timestamp of most recent modification
#     -r --reverse        reverse order of files
#     -R --recurse        recurse into directories
#     -s --sort WORD      field to sort by
#     -S --blocks         show number of file system blocks
#     -t --time WORD      which timestamp to show for a file
#     -T --tree           recurse into subdirectories in a tree view
#     -u --accessed       display timestamp of last access for a file
#     -U --created        display timestamp of creation for a file
#     -x --across         sort multi-column view entries across
#     -? --help           show list of command-line options
#
###############################################################################

# For semi-ubuntu style shortcuts:
#   alias e='exa -1'
#   alias ea='exa -a1'
#   alias ee='exa -hla'

# e()
#
# exa 0.4.0 is incompatible with macOS Sierra 10.12. Fall back to `ls` when
# this combination is detected.
e() {
  if is_sierra &&
     [[ "$(md5 -q "$(which exa)")" == "1a29b3a8e16e3b00095f00eac2201d60" ]]
  then # exa version is 0.4.0
    printf "(⊱!⊰) exa v0.4.0 detected on Sierra. Falling back to \`ls\`...\n"
    ls -lha "$@"
  else
    exa -la --git "$@"
  fi
}
alias eh='exa -hla'
alias ee='exa -l'
alias eeh='exa -hl'
alias et='exa -a --tree'
alias etl='exa -la --tree'
