###############################################################################
# nix
#
# Nix is a powerful package manager for Linux and other Unix systems that
# makes package management reliable and reproducible. It provides atomic
# upgrades and rollbacks, side-by-side installation of multiple versions of a
# package, multi-user package management and easy setup of build environments.
#
# https://nixos.org/nix/
#
# See also:
# https://www.domenkozar.com/2014/01/02/getting-started-with-nix-package-manager/
###############################################################################

# Initialize nix if it's installed.
nix_init() {
  _nix_sh_path="${HOME}/.nix-profile/etc/profile.d/nix.sh"
  if [[ -e "${_nix_sh_path}" ]]
  then
    . "${_nix_sh_path}"
  fi
}
nix_init
