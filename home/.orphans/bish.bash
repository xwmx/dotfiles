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
  if [[ -f "$HOME/bin/bish" ]]
  then
    printf "bish already installed.\n" && exit 0
  fi

  local binary_name="bish"
  local tmp_repo="/tmp/orphans/bish"
  local remote_url="https://github.com/tdenniston/bish.git"

  git clone "$remote_url" "$tmp_repo" &&
    cd "$tmp_repo" &&
    make &&
    cp "$tmp_repo/$binary_name" "$HOME/bin" &&
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
  [[ -e "$HOME/bin/bish"    ]] && _remove "$HOME/bin/bish"
  [[ -e "/tmp/orphans/bish" ]] && _remove "/tmp/orphans/bish"

}
