#! /bin/sh

if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/scoop/shims" ] ; then
    PATH="$HOME/scoop/shims:$PATH"
fi
