# config file and template information

The configuration file in this directory is generated using the
corresponding .template file. The template processing script can be
found at the following location:

[`"$DOTSPATH"/script/install/cabal-packages`
](https://github.com/alphabetum/dotfiles/blob/master/script/install/cabal-packages)

The config.platform file is installed by the haskell platform
installation process and demonstrates the expected standard
configuration for the platform (OS X).

The config.platform file is not used directly, but is used for
reference. As noted in the help wiki:

> the config file for this layout is placed in ~/.cabal/config.platform and
> you can manually move it over, or incorporate it into your existing config
> file.

For more information, see:

https://wiki.haskell.org/Mac_OS_X_Common_Installation_Paths
