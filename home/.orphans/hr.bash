export PREFIX="$HOME/.hyperlocal"
export BIN="$PREFIX/bin"
export MAN="$PREFIX/share/man/man1"

desc "hr:up" <<EOM
Usage:
  $_ME hr:up

Description:
  \`<hr />\` for your terminal.

  https://github.com/LuRsT/hr
EOM
hr:up() {

  # Don't install if already installed.
  [[ -f "$PREFIX/bin/hr" ]] && "hr already installed.\n" && exit 0

  [[ ! -d "$BIN" ]] && mkdir -p "$BIN"
  curl https://raw.githubusercontent.com/LuRsT/hr/master/hr > \
    "$BIN/hr"
  chmod +x "$BIN/hr"

  [[ ! -d "$MAN" ]] && mkdir -p "$MAN"
  curl https://raw.githubusercontent.com/LuRsT/hr/master/hr.1 > \
    "$MAN/hr.1"
}

desc "hr:down" <<EOM
Usage:
  $_ME hr:down

Description:
  Uninstall hr.
EOM
hr:down() {
  printf ">> Uninstalling hr\n"
  [[ -e "$BIN/hr"   ]] && _remove "$BIN/hr"
  [[ -e "$MAN/hr.1" ]] && _remove "$MAN/hr.1"
}
