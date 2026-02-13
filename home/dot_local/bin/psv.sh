#!/bin/sh

#
# psv: Portable services. A simple sevice manager written in posixly correct shell script.
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
PSV_STATE_DIR="${PSV_STATE_DIR:-${XDG_STATE_HOME:-$HOME/.local/state}/psv}"

_psv_help() { cat <<EOF

Usage psv.sh [options...] <command> [args...]
Options:
  --version <${PSV_VERSION}>
    Set what version of the command set you are working with. This will default to the highest version supported by this instance of the code.
  --config <PSV_CONFIG_DIR>
    Set the folder to read the configurations.
  --state <PSV_STATE_DIR>
    Set the folder to store the pid and other local state information.
  --format (nestedtext|properties)
    Set the output to be either NestedText or a Java Properties file syntax. NestedText is more human readable, Java Properties is easier to parse in shell scripts.
Commands in version 0.0.1:
  queue add [--] <command line>
    https://github.com/Nukesor/pueue?tab=readme-ov-file
    Enqueue a task to run in the background. When the previous task in the queue exits, start the next task.
  queue list
    https://github.com/Nukesor/pueue?tab=readme-ov-file
    List the enqueued tasks. Finished tasks will have their exit status.
  queue remove <id>
    Remove a task from the queue. A task that is currently running, will be stopped before being removed.

Commands in a future version:
  status
    https://smarden.org/runit/sv.8
  up <service>
    https://smarden.org/runit/sv.8
    https://github.com/lime-scripts/supervisor/blob/main/supervisor.sh
    https://github.com/kwatch/reraise
  down <service>
    https://smarden.org/runit/sv.8
    https://github.com/lime-scripts/supervisor/blob/main/supervisor.sh
    https://github.com/kwatch/reraise
  require <service>
    https://smarden.org/runit/sv.8
    Same as up, but wait for up to 7 seconds for the service to finish starting.
  envdir <dir>
    https://www.skarnet.org/software/s6/s6-envdir.html
  supervise <service>
    https://www.skarnet.org/software/s6/s6-supervise.html
    https://smarden.org/runit/runsv.8
    Use ${PSV_CONFIG_DIR}/<service>/ for the service definition.
    Use ${PSV_STATE_DIR}/<service>/ for the pid file, control pipe, and state information.
  supervisor
    https://www.skarnet.org/software/s6/s6-svscan.html
    https://smarden.org/runit/runsvdir.8
    Use ${PSV_CONFIG_DIR}/<...> for the service definitions.
    Use ${PSV_STATE_DIR}/psv/ for the pid file, control pipe, and state information.
  logger
    https://smarden.org/runit/svlogd.8
Design:
  Service names starting with a symbol are internal to psv.sh and defined in ${PSV_STATE_DIR}/<id>.
  Service names starting with a number are enqueued commands, defined in ${PSV_STATE_DIR}/<id>, and may be cleaned up by psv.sh.
  Service names starting with a letter are user defined services and defined in ${PSV_CONFIG_DIR}/<service>.

  A service folder must have a run script, and may have check and finish scripts.  It may also have a log subdirectory with a run script.

  All command output will be formatted as Minimal NestedText (https://nestedtext.org/en/latest/minimal-nestedtext.html).


EOF
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