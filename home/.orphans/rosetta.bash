desc "rosetta:up" <<EOM
Usage:
  $_ME rosetta:up

Description:
  Tools for data science with a focus on text processing.

  https://github.com/columbia-applied-data-science/rosetta

  NOTE:
  - Requires Pandas
  - Requires Python 2 and will fail on Python 3 with the following error:
    "ImportError: No module named 'StringIO'"
  - Requires pymongo
EOM
rosetta:up() {
  # Don't install if already installed.
  if [[ -n "$(pip show rosetta)" ]]
  then
    printf "Rosetta is already installed.\n" && exit 0
  fi

  local tmp_repo=/tmp/orphans/rosetta
  local remote_url=https://github.com/columbia-applied-data-science/rosetta.git

  git clone "$remote_url" "$tmp_repo" &&
    cd "$tmp_repo" &&
    make install
}

desc "rosetta:down" <<EOM
Usage:
  $_ME rosetta:down

Description:
  Uninstall rosetta.
EOM
rosetta:down() {
  printf ">> Uninstalling rosetta\n"
  local tmp_location="/tmp/orphans/rosetta"
  if [[ -n "$(pip show rosetta)" ]]
  then
    pip uninstall rosetta -y
  fi
  [[ -e "$tmp_location" ]] && _remove "$tmp_location"
}
