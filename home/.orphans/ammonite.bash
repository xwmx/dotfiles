_AMMONITE_PREFIX="${HOME}/.hyperlocal"

desc "ammonite:up" <<EOM
Usage:
  $_ME ammonite:up

Description:
  Ammonite is a cleanroom re-implementation of the Scala REPL from first
  principles. It is much more featureful than the default REPL and comes with
  a lot of ergonomic improvements and configurability that may be familiar to
  people coming from IDEs or other REPLs such as IPython or Zsh. It can be
  combined with Ammonite-Ops to replace Bash as your systems shell, but also
  can be used alone as a superior version of the default Scala REPL, or as a
  debugging tool.

  Ammonite-Ops is a library to make common filesystem operations in Scala as
  concise and easy-to-use as from the Bash shell, while being robust enough to
  use in large applications without getting messy. It lives in the same repo
  as the Ammonite REPL, but can easily be used stand-alone in a normal
  SBT/maven project.

Links:
  http://lihaoyi.github.io/Ammonite/
  https://github.com/lihaoyi/ammonite
  http://tinyurl.com/beyondbash
  https://news.ycombinator.com/item?id=10068058
EOM
ammonite:up() {

  # Don't install if it is already installed.
  if [[ -e "${_AMMONITE_PREFIX}/bin/amm" ]]
  then
    printf "ammonite already installed.\n" && exit 0
  fi

  printf ">> Installing ammonite\n"

  cd "${_AMMONITE_PREFIX}/bin" &&
    curl -L -o amm http://git.io/v3Xln &&
    chmod +x amm
}

desc "ammonite:down" <<EOM
Usage:
  $_ME ammonite:down

Description:
  Uninstall ammonite.
EOM
ammonite:down() {
  printf ">> Uninstalling ammonite.\n"
  [[ -e "${_AMMONITE_PREFIX}/bin/amm" ]] &&
    _remove "${_AMMONITE_PREFIX}/bin/amm"
}

