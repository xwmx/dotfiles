export PREFIX="$HOME/.hyperlocal"

desc "iota:up" <<EOM
Usage:
  $_ME iota:up

Description:
  Iota is a terminal-based text-editor written in Rust.

  https://github.com/gchp/iota

  NOTE: included as an orhan because a rust crate doesn't appear to exist for
  it yet and, therefore, it needs to be built with cargo.
EOM
iota:up() {
  # Don't install if already installed.
  if [[ -f "$PREFIX/bin/iota" ]]
  then
    printf "iota already installed.\n" && exit 0
  fi

  # Remove iota if installed in old location.
  # TODO: remove this line.
  [[ -e "$HOME/bin/iota" ]] && _remove "$HOME/bin/iota"

  printf ">> Installing iota\n"

  local binary_name="iota"
  local tmp_repo=/tmp/orphans/iota
  local remote_url=https://github.com/gchp/iota.git

  git clone "$remote_url" "$tmp_repo" &&
    cd "$tmp_repo" &&
    cargo build &&
    [[ ! -d "$PREFIX/bin" ]] && mkdir -p "$PREFIX/bin" || true &&
    cp "$tmp_repo/target/$binary_name" "$PREFIX/bin/" &&
    cd "/tmp/orphans" &&
    _remove "$tmp_repo"
}

desc "iota:down" <<EOM
Usage:
  $_ME iota:down

Description:
  Uninstall iota.
EOM
iota:down() {
  printf ">> Uninstalling iota\n"
  # Remove iota if installed in old location.
  # TODO: remove this line.
  [[ -e "$HOME/bin/iota" ]] && _remove "$HOME/bin/iota"

  [[ -e "$PREFIX/bin/iota"  ]] && _remove "$PREFIX/bin/iota"
  [[ -e "/tmp/orphans/iota" ]] && _remove "/tmp/orphans/iota"
}
