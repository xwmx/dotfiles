# config file and template information

## config / config.template

The config file in this directory is generated using the corresponding
.template file because the paths in .cabal/config have to be absolute paths
and therefore end up containing user-specific information.

To make changes to the configuration, edit config.template and then
generate a new config file using the `generate_config.sh` script.

## config.platform

The config.platform file is an untracked file installed by the haskell platform
installation process and demonstrates the expected standard configuration for
the platform (OS X).

The config.platform file is not used directly, but is used for
reference. As noted in the help wiki:

> the config file for this layout is placed in ~/.cabal/config.platform and
> you can manually move it over, or incorporate it into your existing config
> file.

For more information, see:

https://wiki.haskell.org/Mac_OS_X_Common_Installation_Paths
