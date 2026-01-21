#! /bin/sh

# Set the default umask in case it isn't set elsewhere.
umask 022

# Use busybox vi.
export VISUAL="vi"
export EDITOR="vi"

export ENV="$HOME/.shenv"