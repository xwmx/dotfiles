#!/usr/bin/env bash
#
# luarocks.sh
#
# Install various global lua rocks.


# Mjolnir
#
# Lightweight automation and productivity app for OS X. Mjolnir is an OS X app
# that lets you automate common tasks using the language Lua. At its core, it
# doesn't actually do anything besides load up a Lua environment; the real
# power lies in all the useful modules that you can install.
#
# https://github.com/sdegutis/mjolnir
luarocks install mjolnir.hotkey
luarocks install mjolnir.application
