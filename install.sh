#! /bin/sh
#
# The expectation is that you have a Posix, or Posix like, environment to run
# this script.  Bash from Git for Windows does count. As does Termux on Android,
# and a-Shell on iPhone/iPad.
#
# this script will finish adding the remaining dependencies, install the age.key,
# generate an ssh key, and swap the repo to using ssh.


if type termux-change-repo >/dev/null ; then
	# Running in Termux on Android
	termux-change-repo
	pkg update
	pkg upgrade
	pkg install chezmoi
fi

chezmoi age decrypt ~/.local/share/chezmoi/home/dot_config/chezmoi/.age.key --output ~/.config/chezmoi/age.key --passphrase
