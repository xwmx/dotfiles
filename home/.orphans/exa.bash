desc "exa:up" <<EOM
Usage:
  $_ME exa:up

Description:
  \`exa\` is a modern replacement for ls. It uses colours for information by
  default, helping you distinguish between many types of files, such as whether
  you are the owner, or in the owning group. It also has extra features not
  present in the original ls, such as viewing the Git status for a directory,
  or recursing into directories with a tree view. \`exa\` is written in Rust,
  so it's small, fast, and portable.

  http://bsago.me/exa/

  NOTE: included as an orhan because a rust crate doesn't appear to exist for
  it yet and, therefore, it needs to be built with cargo.
EOM
exa:up() {
  local version="0.4.0"
  local url
  local binary_name
  local tmp_location=/tmp/orphans/exa

  if [[ "$OSTYPE" =~ ^darwin ]]
  then
    binary_name="exa-osx-x86_64"
  elif [[ "$OSTYPE" =~ ^linux ]]
  then
    binary_name="exa-linux-x86_64"
  else
    printf "Unsupported platform.\n"
    exit 1
  fi

  url="https://github.com/ogham/exa/releases/download/v${version}/${binary_name}.zip"

  # Don't install if exa is already installed.
  if [[ -e "$HOME/bin/exa" ]] || hash "exa" 2>/dev/null
  then
    printf "exa already installed.\n" && exit 0
  fi

  printf ">> Installing exa\n"

  mkdir -p "${tmp_location}"

  curl -Ls "${url}" -o "${tmp_location}/${binary_name}.zip"

  unzip "${tmp_location}/${binary_name}.zip"
  mv "${tmp_location}/${binary_name}.zip" "${HOME}/bin/exa"
  _remove "${tmp_location}"
}

desc "exa:down" <<EOM
Usage:
  $_ME exa:down

Description:
  Uninstall exa.
EOM
exa:down() {
  printf ">> Uninstalling exa\n"
  [[ -e "$HOME/bin/exa"    ]] && _remove "$HOME/bin/exa"
  [[ -e "/tmp/orphans/exa" ]] && _remove "/tmp/orphans/exa"
}
