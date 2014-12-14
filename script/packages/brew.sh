#!/usr/bin/env bash

# Install programs and applications using Homebrew and Homebrew Cask.

# http://brew.sh/
# http://caskroom.io/

###############################################################################
# Homebrew - Update
###############################################################################

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

###############################################################################
# Homebrew - Formula
###############################################################################

# ----------------------------------------------------------------------------
# Utilities and Basic Programs
# ----------------------------------------------------------------------------

# GNU Core Utilities
#
# For using in place of outdated OS X versions.
#
# https://www.gnu.org/software/coreutils
#
# NOTE: To use, add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum

# moreutils
#
# moreutils is a growing collection of the unix tools that nobody thought to
# write long ago when unix was young, eg, `sponge`.
#
# http://joeyh.name/code/moreutils/
brew install moreutils

# findutils
#
# GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
#
# http://www.gnu.org/software/findutils/
brew install findutils

# GNU sed
#
# sed (stream editor) isn't an interactive text editor.
#
# https://www.gnu.org/software/sed/
#
# NOTE: overwriting the built-in `sed`
brew install gnu-sed --default-names


# GNU Bash
#
# Bash 4. Newer than OS X default.
#
# http://www.gnu.org/software/bash/
#
# NOTE: don’t forget to add `/usr/local/bin/bash` to `/etc/shells` before
# running `chsh`.
brew install bash
brew install bash-completion

# GNU wget
#
# GNU Wget is a free software package for retrieving files using HTTP, HTTPS
# and FTP, the most widely-used Internet protocols.
#
# https://www.gnu.org/software/wget/
#
# NOTE: including support of IRIs, Internationalized Resource Identifiers,
# which are similar to URI, but allow unicode charaters to be used.
brew install wget --with-iri

# RingoJS and Narwhal.
#
# Ringo is a CommonJS-based JavaScript runtime written in Java and based on the
# Mozilla Rhino JavaScript engine.
#
# http://ringojs.org
#
# Narwhal is a cross-platform, multi-interpreter, general purpose JavaScript
# platform. It aims to provide a solid foundation for building JavaScript
# applications, primarily outside the web browser. Narwhal includes a package
# manager, module system, and standard library for multiple JavaScript
# interpreters.
#
# https://github.com/280north/narwhal
#
# NOTE: the order in which these are installed is important. See:
# http://git.io/brew-narwhal-ringo.
brew install ringojs
brew install narwhal

# ----------------------------------------------------------------------------
# More recent versions of some OS X tools.
# ----------------------------------------------------------------------------

brew install vim --override-system-vi
brew install homebrew/dupes/grep
brew install homebrew/dupes/screen
brew install homebrew/php/php55 --with-gmp

# ----------------------------------------------------------------------------
# CTF tools
# https://github.com/ctfs/write-ups
# ----------------------------------------------------------------------------

# bfg repo-cleaner
#
# Removes large or troublesome blobs like git-filter-branch does, but faster.
# And written in Scala
#
# http://rtyley.github.io/bfg-repo-cleaner/
brew install bfg

# GNU binutils
#
# http://www.gnu.org/software/binutils/binutils.html
brew install binutils

# binwalk
#
# Firmware Analysis Tool
# Binwalk is a fast, easy to use tool for analyzing and extracting firmware
# images.
#
# http://binwalk.org/
brew install binwalk

# cifer
#
# Work on automating classical cipher cracking in C.
#
# http://code.google.com/p/cifer/
brew install cifer

# dex2jar
#
# Tools to work with android .dex and java .class files
#
# https://code.google.com/p/dex2jar/
brew install dex2jar

# Dns2tcp
#
# Dns2tcp is a network tool designed to relay TCP connections through DNS
# traffic. Encapsulation is done on the TCP level, thus no specific driver is
# needed (i.e: TUN/TAP). Dns2tcp client doesn't need to be run with specific
# privileges.
#
# http://www.hsc.fr/ressources/outils/dns2tcp/index.html.en
brew install dns2tcp

# FCrackZip
#
# fcrackzip is a zip password cracker, similar to fzc, zipcrack and others.
#
# http://oldhome.schmorp.de/marc/fcrackzip.html
brew install fcrackzip

# Foremost
#
# Foremost is a console program to recover files based on their headers,
# footers, and internal data structures.
#
# http://foremost.sourceforge.net/
brew install foremost

# HashPump
#
# A tool to exploit the hash length extension attack in various hashing algorithms
#
# https://github.com/bwall/HashPump
brew install hashpump

# THC-Hydra
#
# A very fast network logon cracker which support many different services.
#
# https://www.thc.org/thc-hydra/
brew install hydra

# John the Ripper
#
# John the Ripper is a fast password cracker, currently available for many
# flavors of Unix, Windows, DOS, BeOS, and OpenVMS.
#
# http://www.openwall.com/john/
brew install john

# knockd
#
# a port-knocking server
#
# http://www.zeroflux.org/projects/knock
brew install knock

# Nmap
#
# Nmap ("Network Mapper") is a free and open source (license) utility for
# network discovery and security auditing.
#
# http://nmap.org/
brew install nmap

# pngcheck
#
# pngcheck verifies the integrity of PNG, JNG and MNG files
#
# http://www.libpng.org/pub/png/apps/pngcheck.html
brew install pngcheck

# socat - Multipurpose relay
#
# socat is a relay for bidirectional data transfer between two independent data
# channels.
#
# http://www.dest-unreach.org/socat/
brew install socat

# sqlmap
#
# Automatic SQL injection and database takeover tool
#
# http://sqlmap.org
brew install sqlmap

# tcpflow
#
# TCP/IP packet demultiplexer
#
# https://github.com/simsong/tcpflow
brew install tcpflow

# Tcpreplay - Pcap editing and replaying utilities
#
# Tcpreplay is a suite of free Open Source utilities for editing and replaying
# previously captured network traffic.
#
# http://tcpreplay.appneta.com
brew install tcpreplay

# tcptrace
#
# tcptrace is a tool for analysis of TCP dump files.
#
# http://www.tcptrace.org/
brew install tcptrace

# ucspi-tcp
#
# tcpserver and tcpclient are easy-to-use command-line tools for building TCP
# client-server applications.
#
# http://cr.yp.to/ucspi-tcp.html
brew install ucspi-tcp

# Xpdf
#
# Xpdf is an open source viewer for Portable Document Format (PDF) files.
#
# http://www.foolabs.com/xpdf/
brew install xpdf

# XZ Utils
#
# XZ Utils is free general-purpose data compression software with high
# compression ratio.
#
# http://tukaani.org/xz/
brew install xz

# ----------------------------------------------------------------------------
# Programs
# ----------------------------------------------------------------------------

# homebrew-completions
#
# Shell completion formulae for the Homebrew package manager
#
# https://github.com/Homebrew/homebrew-completions
brew tap homebrew/completions

# Ack
#
# Ack is a tool like grep, optimized for programmers
#
# http://beyondgrep.com/
brew install ack

# djvu2pdf
#
# A small tool to convert Djvu files to PDF files.
#
# http://0x2a.at/s/projects/djvu2pdf
#
# See also:
# http://djvu.sourceforge.net/
# https://en.wikipedia.org/wiki/DjVu
brew install djvu2pdf

# ELinks - Full-Featured Text WWW Browser
#
# ELinks is an advanced and well-established feature-rich text mode web
# (HTTP/FTP/..) browser.
#
# http://elinks.or.cz/
brew install elinks

# Elixir
#
# Elixir is a dynamic, functional language designed for building scalable and
# maintainable applications.
#
# http://elixir-lang.org/
brew install elixir

# Exiv2
#
# Image metadata library and tools
#
# http://www.exiv2.org
#brew install exiv2

# FFmpeg
#
# A complete, cross-platform solution to record, convert and stream audio and
# video.
#
# https://ffmpeg.org/
brew install ffmpeg

# Flow
#
# Flow is a static type checker, designed to find type errors in JavaScript
# programs.
#
# http://flowtype.org/
brew install flow

# git
#
# Git is a free and open source distributed version control system designed to
# handle everything from small to very large projects with speed and efficiency
#
# http://git-scm.com
brew install git

# htop (htop-osx)
#
# htop, an interactive process viewer.
#
# https://github.com/max-horvath/htop-osx
brew install htop

# hub
#
# hub is a command-line wrapper for git that makes you better at GitHub.
#
# http://hub.github.com/
brew install hub

# ImageMagick
#
# ImageMagick® is a software suite to create, edit, compose, or convert bitmap
# images. It can read and write images in a variety of formats (over 100)
# including DPX, EXR, GIF, JPEG, JPEG-2000, PDF, PNG, Postscript, SVG, and
# TIFF. Use ImageMagick to resize, flip, mirror, rotate, distort, shear and
# transform images, adjust image colors, apply various special effects, or draw
# text, lines, polygons, ellipses and Bézier curves.
#
# http://www.imagemagick.org
#
# Build notes:
#
# --with-webp - build with support for the webp image format:
#
# https://developers.google.com/speed/webp/?csw=1
brew install imagemagick --with-webp

# Leiningen
#
# Automate Clojure projects without setting your hair on fire.
#
# https://github.com/technomancy/leiningen
brew install leiningen

# lesspipe
#
# lesspipe.sh is an input filter for the pager less as described in less's man
# page.
#
# http://www-zeuthen.desy.de/~friebel/unix/lesspipe.html
brew install lesspipe

# Lua
#
# Lua is a powerful, fast, lightweight, embeddable scripting language.
#
# http://www.lua.org/
brew install lua

# Lynx
#
# Lynx is a fully-featured World Wide Web (WWW) client for users running
# cursor-addressable, character-cell display devices such as vt100 terminals
#
# http://lynx.isc.org/release/
brew install lynx

# MacVim
#
# The text editor Vim for Mac OS X.
#
# http://code.google.com/p/macvim/
brew install macvim

# Memcached
#
# Free & open source, high-performance, distributed memory object caching
# system, generic in nature, but intended for use in speeding up dynamic web
# applications by alleviating database load.
#
# http://memcached.org/
brew install memcached

# Mercurial
#
# Mercurial is a free, distributed source control management tool.
#
# http://mercurial.selenic.com/
brew install mercurial

# MIT/GNU Scheme
#
# MIT/GNU Scheme is an implementation of the Scheme programming language,
# providing an interpreter, compiler, source-code debugger, integrated
# Emacs-like editor, and a large runtime library.
#
# http://www.gnu.org/software/mit-scheme/
brew install mit-scheme

# MOST
#
# MOST is a powerful paging program for Unix, VMS, MSDOS, and win32 systems.
# Unlike other well-known paging programs most supports multiple windows and
# can scroll left and right.
#
# http://www.jedsoft.org/most/
brew install most

# ngrep - network grep
#
# ngrep strives to provide most of GNU grep's common features, applying them to
# the network layer. ngrep is a pcap-aware tool that will allow you to specify
# extended regular or hexadecimal expressions to match against data payloads of packets.
#
# http://ngrep.sourceforge.net/
brew install ngrep

# node.js
#
# Node.js® is a platform built on Chrome's JavaScript runtime. Node.js uses an
# event-driven, non-blocking I/O model
#
# https://nodejs.org/
#
# NOTE: also install npm
brew install node

# nvm - Node Version Manager
#
# Simple bash script to manage multiple active node.js versions
#
# https://github.com/creationix/nvm
brew install nvm

# OCaml
#
# OCaml, originally known as Objective Caml, is the main implementation of the
# Caml programming language.
#
# http://ocaml.org
brew install ocaml

# OPAM - OCaml Package Manager
#
# OPAM is a source-based package manager for OCaml. It supports multiple
# simultaneous compiler installations, flexible package constraints, and a
# Git-friendly development workflow.
#
# https://opam.ocaml.org
brew install opam

# osxutils
#
# osxutils is a bundle of Mac OS X command line utilities that bring power over
# all sorts of Mac-specific information, settings and meta-data to the command
# line.
#
# https://github.com/vasi/osxutils
brew install osxutils

# p7zip
#
# A file archiver with a high compression ratio. p7zip is a port of 7za.exe for
#POSIX systems like Unix.
#
# http://p7zip.sourceforge.net/
brew install p7zip

# Pandoc
#
# Pandoc converts files from one markup format into another
#
#http://johnmacfarlane.net/pandoc/
brew install pandoc

# pigz
#
# A parallel implementation of gzip for modern multi-processor, multi-core
# machines
#
# http://www.zlib.net/pigz/
brew install pigz

# pv - Pipe Viewer
#
# A terminal-based tool for monitoring the progress of data through a pipeline.
#
# http://www.ivarch.com/programs/pv.shtml
brew install pv

# rbenv
#
# Groom your app’s Ruby environment
#
# https://github.com/sstephenson/rbenv
brew install rbenv

# rename
#
# renames files according to modification rules specified on the command line.
#
# http://plasmasturm.org/code/rename
brew install rename

# Redis
#
# Redis is an open source, BSD licensed, advanced key-value cache and store. It
# is often referred to as a data structure server since keys can contain
# strings, hashes, lists, sets, sorted sets, bitmaps and hyperloglogs.
#
# http://redis.io/
brew install redis

# Rhino
#
# Rhino is an open-source implementation of JavaScript written entirely in Java.
#
# http://www.mozilla.org/rhino/
brew install rhino

# Riak
#
# Riak is an open source, distributed database.
#
# http://basho.com/riak/
brew install riak

# Rust
#
# Rust is a systems programming language that runs blazingly fast, prevents
# almost all crashes, and eliminates data races.
#
# http://www.rust-lang.org/
brew install rust

# Scala
#
# Scala is an object-functional programming language for general software
# applications.
#
# http://www.scala-lang.org/
brew install scala

# Siege
#
# Siege is an http load testing and benchmarking utility.
#
# http://www.joedog.org/index/siege-home
brew install siege

# Sphinx
#
# Sphinx is a free software/open source Fulltext search engine designed to
# provide full-text search functionality to client applications.
#
# http://www.sphinxsearch.com
brew install sphinx

# GNU Stow
#
# GNU Stow is a symlink farm manager which takes distinct packages of software
# and/or data located in separate directories on the filesystem, and makes
# them appear to be installed in the same place.
#
# http://www.gnu.org/software/stow/
brew install stow

# tree
#
# Tree is a recursive directory listing command that produces a depth indented
# listing of files.
#
# http://mama.indstate.edu/users/ice/tree/
brew install tree

# Tig - text-mode interface for Git
#
# Tig is an ncurses-based text-mode interface for git. It functions mainly as a
# Git repository browser, but can also assist in staging changes for commit at
# chunk level and act as a pager for output from various Git commands.
#
# http://jonas.nitro.dk/tig/
brew install tig

# tmux
#
# tmux is a terminal multiplexer. It lets you switch easily between several
# programs in one terminal, detach them (they keep running in the background)
# and reattach them to a different terminal.
#
# http://tmux.sourceforge.net
brew install tmux

# tmuxinator
#
# Manage complex tmux sessions easily
#
# https://github.com/tmuxinator/tmuxinator
brew install tmuxinator-completion

# The Silver Searcher
#
# A code-searching tool similar to ack, but faster.
#
# https://github.com/ggreer/the_silver_searcher
# http://geoff.greer.fm/ag/
#
# NOTE: command name is `ag`
brew install the_silver_searcher

# webkit2png
#
# webkit2png is a command line tool that creates screenshots of webpages
#
# http://www.paulhammond.org/webkit2png/
brew install webkit2png

# Wine
#
# Run Windows applications on Linux, BSD, Solaris and Mac OS X.
#
# http://winehq.org/
brew install wine

# Winetricks
#
# Winetricks is an easy way to work around problems in Wine.
#
# http://code.google.com/p/winetricks/
brew install winetricks

# Zopfli
#
# Zopfli Compression Algorithm is a new zlib (gzip, deflate) compatible
# compressor. This compressor takes more time (~100x slower), but compresses
# around 5% better than zlib and better than any other zlib-compatible
# compressor.
#
# https://code.google.com/p/zopfli/
brew install zopfli


###############################################################################
# Homebrew - Linking
###############################################################################

# linkapps
#
# link apps installed with homebrew. Pass the `--local` flag in order to
# symlink apps to ~/Applications.
#
# NOTE: first unlinking apps to cleanup old links that apparently sometimes
# stick around.
brew unlinkapps --local
brew linkapps --local

###############################################################################
# Homebrew Cask
###############################################################################

# install brew cask
brew install caskroom/cask/brew-cask
# tap caskroom/versions for alternative versions
brew tap caskroom/versions

# VirtualBox
#
# VirtualBox is a powerful x86 and AMD64/Intel64 virtualization product.
#
# http://www.virtualbox.org
#
# NOTE: Installing first since it's important and other casks use it.
brew cask install virtualbox

# Android Studio
#
# https://developer.android.com/sdk/index.html
brew cask install android-studio

# Atom
#
# A hackable text editor for the 21st Century.
#
# http://atom.io
brew cask install atom

# Brackets
#
# Adobe's open source text editor built with and focused on web technologies.
#
# http://brackets.io
brew cask install brackets

# Breach
#
# A new modular browser. Entirely written in Javascript. Free. Hackable.
#
# http://breach.cc
brew cask install breach

# Cakebrew
#
# The Mac App for Homebrew.
#
# http://www.cakebrew.com
brew cask install cakebrew

# Codebox
#
# Open source cloud & desktop IDE.
#
# https://www.codebox.io
brew cask install codebox

# Consul
#
# Consul is a tool for service discovery, monitoring and configuration.
#
# http://www.consul.io/
brew cask install consul

# GnuCash
#
# GnuCash is open source personal and small-business financial-accounting
# software.
#
# http://www.gnucash.org
brew cask install gnucash

# The Haskell Platform
#
# http://www.haskell.org/platform/
brew cask install haskell-platform

# iTerm2
#
# iTerm2 is a replacement for Terminal and the successor to iTerm.
#
# http://www.iterm2.com/
brew cask install iterm2-nightly

# KindleGen
#
# KindleGen is a command line tool which enables publishers to work in an
# automated environment with a variety of source content including HTML, XHTML
# or EPUB. KindleGen converts this source content to a single file which
# supports both KF8 and Mobi formats enabling publishers to create
# great-looking books that work on all Kindle devices and apps.
#
# http://www.amazon.com/gp/feature.html?docId=1000765211
brew cask install kindlegen

# Light Table
#
# A text editor and IDE build with JavaScript.
#
# http://www.lighttable.com/
# https://github.com/LightTable/LightTable
brew cask install lighttable

# MacTex
#
# MacTeX is an OS X-specific redistribution of TeX Live, a typesetting
# environment.
#
# http://www.tug.org/mactex/
brew cask install mactex

# Packer
#
# Packer is a tool for creating identical machine images for multiple platforms
# from a single source configuration.
#
# http://www.packer.io/
brew cask install packer

# Secrets
#
# A database of hidden settings for Mac OS X
#
# http://secrets.blacktree.com
brew cask install secrets

# Vagrant
#
# Create and configure lightweight, reproducible, and portable development
# environments.
#
# http://www.vagrantup.com
brew cask install vagrant

# Vico
#
# Vico is a programmers text editor with a strong focus on keyboard control and
# uses vi key bindings.
#
# http://www.vicoapp.com
brew cask install vico

# VimR
#
# A Vim GUI for OS X
#
# http://vimr.org/
brew cask install vimr

# Zed
#
# Zed is a fully offline-capable, open source, keyboard-focused, text and code
# editor for power users.
#
# http://zedapp.org
brew cask install zed


###############################################################################
# Docker
#
# https://www.docker.com/
#
# Installing last because it requires a multi-step process and depends on
# casks.
###############################################################################


brew install boot2docker
# To have launchd start boot2docker at login:
#     ln -sfv /usr/local/opt/boot2docker/*.plist ~/Library/LaunchAgents
# Then to load boot2docker now:
#     launchctl load ~/Library/LaunchAgents/homebrew.mxcl.boot2docker.plist
ln -sfv /usr/local/opt/boot2docker/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.boot2docker.plist
brew install docker

###############################################################################
# Cleanup
###############################################################################

# Remove outdated versions from the cellar.
brew cleanup
brew cask cleanup

###############################################################################
# Application Aliasing
###############################################################################

# Call custom brew aliasapps and brew cask aliasapps commands
brew aliasapps
brew cask aliasapps
