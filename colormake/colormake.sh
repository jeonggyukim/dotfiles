#!/usr/bin/env bash

# Colored Make 2015.2.11
# Copyright (c) 2014 Renato Silva
# GNU GPLv2 licensed

# This script will colorize output of make and GCC so it becomes easier to
# notice the errors and warnings in the complex build output.

# Enable 256 colors for MinTTY in MSYS2
if [[ "$MSYSCON" = mintty* && "$TERM" = *256color* ]]; then
    red="\e[38;05;9m"
    green="\e[38;05;76m"
    blue="\e[38;05;74m"
    cyan="\e[0;36m"
    purple="\e[38;05;165m"
    yellow="\e[0;33m"
    gray="\e[38;05;244m"
else
    red="\e[1;31m"
    green="\e[1;32m"
    blue="\e[1;34m"
    cyan="\e[1;36m"
    purple="\e[1;35m"
    yellow="\e[1;33m"
    gray="\e[1;30m"
fi
normal="\e[0m"

# Errors, warnings, notes and compiler recipes
error="s/(^error|^.*[^a-z]error:)/$(printf $red)\\1$(printf $normal)/i"
warning="s/(^warning|^.*[^a-z]warning:)/$(printf $yellow)\\1$(printf $normal)/i"
make="s/^make(\[[0-9]+\])?:/$(printf $blue)make\\1:$(printf $normal)/"
compiler_recipe="s/^(gcc(.exe)? .*)/$(printf $gray)\\1$(printf $normal)/"

# install gnu-sed in MacOSX e.g., brew install gnu-sed --with-default-names
# https://www.topbug.net/blog/2013/04/14/install-and-use-gnu-command-line-tools-in-mac-os-x/
command make "$@" 2> >(sed -r -e "$warning" -e "$error" -e "$make" -e "$compiler_recipe") \
        > >(sed -E -e "$warning" -e "$error" -e "$make" -e "$compiler_recipe")
