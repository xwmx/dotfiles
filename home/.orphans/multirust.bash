_MULTIRUST_PREFIX="$HOME/.hyperlocal"
_MULTIRUST_TMP_PATH="/tmp/orphans/multirust"

desc "multirust:up" <<EOM
Usage:
  $_ME multirust:up

Description:
  A simple tool for managing multiple installations of the Rust toolchain. It
  replaces the standard Rust toolchain with components that dynamically choose
  between alternate implementations based on context.

Homepage:
  https://github.com/brson/multirust

Notes:
  This manual installation is required since multirust's \`blastoff.sh\`
  bootstrap script installs to \`/usr/local\` with sudo.
EOM
multirust:up() {

  # Don't install if it is already installed.
  if [[ -e "${_MULTIRUST_PREFIX}/bin/rustc" ]]
  then
    printf "multirust already installed.\n" && exit 0
  fi

  printf ">> Installing multirust\n"

  git clone --recursive \
    "https://github.com/brson/multirust" "${_MULTIRUST_TMP_PATH}" &&
      cd "${_MULTIRUST_TMP_PATH}" &&
      git submodule update --init &&
      ./build.sh &&
      ./install.sh --prefix="${_MULTIRUST_PREFIX}" &&
      _remove "${_MULTIRUST_TMP_PATH}"
}

desc "multirust:down" <<EOM
Usage:
  $_ME multirust:down

Description:
  Uninstall multirust.
EOM
multirust:down() {
  printf ">> Uninstalling multirust.\n"
  [[ -e "${_MULTIRUST_PREFIX}/bin/rustc" ]] &&
    "${_MULTIRUST_PREFIX}/lib/rustlib/uninstall.sh"
  [[ -e "{_MULTIRUST_TMP_PATH}" ]] && _remove "${_MULTIRUST_TMP_PATH}"
}
