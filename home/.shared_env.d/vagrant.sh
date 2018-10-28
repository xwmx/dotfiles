###############################################################################
# Vagrant
#
# Vagrant is a tool for building and distributing development environments.
#
# https://www.vagrantup.com/
# https://github.com/hashicorp/vagrant
###############################################################################

# VAGRANT_DISABLE_VBOXSYMLINKCREATE
#
# via warning displayed during `vagrant up`:
# -----------------------------------------------------------------------------
# Vagrant is currently configured to create VirtualBox synced folders with
# the `SharedFoldersEnableSymlinksCreate` option enabled. If the Vagrant
# guest is not trusted, you may want to disable this option. For more
# information on this option, please refer to the VirtualBox manual:
#
#   https://www.virtualbox.org/manual/ch04.html#sharedfolders
#
# This option can be disabled globally with an environment variable:
#
#   VAGRANT_DISABLE_VBOXSYMLINKCREATE=1
#
# or on a per folder basis within the Vagrantfile:
#
#   config.vm.synced_folder '/host/path', '/guest/path', SharedFoldersEnableSymlinksCreate: false
# -----------------------------------------------------------------------------
VAGRANT_DISABLE_VBOXSYMLINKCREATE=1
