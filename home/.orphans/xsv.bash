export PREFIX="$HOME/.hyperlocal"

desc "xsv:up" <<EOM
Usage:
  $_ME xsv:up

Description:
  A fast CSV toolkit written in Rust.

  xsv is a command line program for indexing, slicing, analyzing, splitting
  and joining CSV files.

  https://github.com/BurntSushi/xsv

  NOTE: included as an orhan because a rust crate doesn't appear to exist for
  it yet and, therefore, it needs to be built with cargo.
EOM
xsv:up() {
  # Don't install if already installed.
  if [[ -f "$PREFIX/bin/xsv" ]]
  then
    printf "xsv already installed.\n" && exit 0
  fi

  # Remove xsc if installed in old location.
  # TODO: remove this line.
  [[ -e "$HOME/bin/xsv" ]] && _remove "$HOME/bin/xsv"


  printf ">> Installing xsv\n"

  local binary_name="xsv"
  local tmp_repo=/tmp/orphans/xsv
  local remote_url=https://github.com/BurntSushi/xsv.git

  git clone "$remote_url" "$tmp_repo" &&
    cd "$tmp_repo" &&
    cargo build &&
    cp "$tmp_repo/target/$binary_name" "$PREFIX/bin" &&
    cd "/tmp/orphans" &&
    _remove "$tmp_repo"
}

desc "xsv:down" <<EOM
Usage:
  $_ME xsv:down

Description:
  Uninstall xsv.
EOM
xsv:down() {
  printf ">> Uninstalling xsv\n"
  # Remove xsc if installed in old location.
  # TODO: remove this line.
  [[ -e "$HOME/bin/xsv" ]] && _remove "$HOME/bin/xsv"

  [[ -e "$PREFIX/bin/xsv"  ]] && _remove "$PREFIX/bin/xsv"
  [[ -e "/tmp/orphans/xsv" ]] && _remove "/tmp/orphans/xsv"
}
