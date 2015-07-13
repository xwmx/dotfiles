export PREFIX="$HOME/.hyperlocal"
desc "bish:up" <<EOM
Usage:
  $_ME bish:up

Description:
  Bish is a language that compiles to Bash. It's designed to give shell
  scripting a more comfortable and modern feel.

  https://github.com/tdenniston/bish
EOM
bish:up() {

  # Don't install if already installed.
  if [[ -f "$PREFIX/bin/bish" ]]
  then
    printf "bish already installed.\n" && exit 0
  fi

  # Remove bish if installed in old location.
  # TODO: remove this line.
  [[ -e "$HOME/bin/bish" ]] && _remove "$HOME/bin/bish"

  local binary_name="bish"
  local tmp_repo="/tmp/orphans/bish"
  local remote_url="https://github.com/tdenniston/bish.git"

  git clone "$remote_url" "$tmp_repo" &&
    cd "$tmp_repo" &&
    make &&
    [[ ! -d "$PREFIX/bin" ]] && mkdir -p "$PREFIX/bin" || true &&
    cp "$tmp_repo/$binary_name" "$PREFIX/bin/" &&
    cd "/tmp/orphans" &&
    _remove "$tmp_repo"
}

desc "bish:down" <<EOM
Usage:
  $_ME bish:down

Description:
  Uninstall bish.
EOM
bish:down() {
  printf ">> Uninstalling bish\n"
  # Remove bish if installed in old location.
  # TODO: remove this line.
  [[ -e "$HOME/bin/bish" ]] && _remove "$HOME/bin/bish"

  [[ -e "$PREFIX/bin/bish"  ]] && _remove "$PREFIX/bin/bish"
  [[ -e "/tmp/orphans/bish"       ]] && _remove "/tmp/orphans/bish"

}
