#!/bin/sh

#
# psv: A simple service management tool built on [pueue](https://github.com/Nukesor/pueue)
#
# This file defines the single function psv and tries to be posixly correct.
#
# Known limitations (aka, bugs we won't fix):
# - None Yet
#

# REF:
# https://github.com/kwatch/reraise
# https://github.com/josefbacik/busybox/blob/master/runit/sv.c
# https://github.com/Nukesor/pueue?tab=readme-ov-file
# https://github.com/sgleizes/xsh/blob/master/xsh.sh
# https://www.shellcheck.net/
# https://github.com/lime-scripts/supervisor/blob/main/supervisor.sh
# https://supervisord.org/index.html
# https://cr.yp.to/daemontools.html
# https://en.wikipedia.org/wiki/Launchd
# https://smarden.org/runit/
# https://www.skarnet.org/software/s6/
# https://linux.die.net/man/7/upstart


# shellcheck shell=sh disable=SC1090 disable=SC1007 disable=SC3043
PSV_VERSION='0.0.1'

PSV_CONFIG_DIR="${PSV_CONFIG_DIR:-${XDG_CONFIG_HOME:-$HOME/.config}/psv}"



throw() {
  echo "$*" >&2
  exit 1
}


usage() { cat <<EOF_USAGE

Usage: psv.sh [options...] <command> [args...]
Commands:
  status <services...>
    Display the status of each service.
  up <services...>
    Start each service, then enqueue a script to re-start the 
  down
  once
  restart
  tail

EOF_USAGE
  printf '%s\n' 
  printf '%s\n' "Usage: psv.sh [options...] <command> [args...]"
  printf '%s\n' 
  printf '%s\n' "-p - Prune empty. Exclude fields with empty values."
  printf '%s\n' "-l - Leaf only. Only show leaf nodes, which stops data duplication."
  printf '%s\n' "-b - Brief. Combines 'Leaf only' and 'Prune empty' options."
  printf '%s\n' "-n - No-head. Do not show nodes that have no path (lines that start with [])."
  printf '%s\n' "-s - Remove escaping of the solidus symbol (straight slash)."
  printf '%s\n' "-h - This help text."
  printf '%s\n' 
}

usage