#!/usr/bin/env bash

# Install script for pip-installed Python packages.
#
# NOTE: both python 2 and python 3 are included in this script, which assumes
# both are installed.
#
# http://www.pip-installer.org/
# https://pip.pypa.io

###############################################################################
# Python 2
###############################################################################

pip install --upgrade setuptools
pip install --upgrade pip

# http://ipython.org/
pip install ipython[all]

# http://mitmproxy.org/
pip install mitmproxy

###############################################################################
# Python 3
###############################################################################

pip3 install --upgrade pip

# Mochi
#
# Dynamically typed functional programming language.
#
# https://github.com/i2y/mochi
pip3 install mochi
