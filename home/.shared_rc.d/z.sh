###############################################################################
# z - jump around.
#
# z is the new j, yo
#
# Tracks your most used directories, based on 'frecency'.
#
# After  a  short  learning  phase, z will take you to the most 'frecent'
# directory that matches ALL of the regexes given on the command line, in
# order.
#
# https://github.com/rupa/z
#
# NOTE:
# Additional files installed in ~/.hyperlocal
###############################################################################

_load_z_sh() {
 local _z_sh_path="${HOME}/.hyperlocal/etc/profile.d/z.sh"
  if [[ -e "${_z_sh_path}" ]]
  then
    source "${_z_sh_path}"
  fi
}

_load_z_sh
