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

if type scoop >/dev/null ; then
	if ! scoop bucket list | grep extras >/dev/null ; then
		scoop bucket add extras
	fi
	scoop update
	for APP in chezmoi git keepassxc pueue pwsh rclone syncthing ; do
		if ! scoop list | grep "$APP" >/dev/null ; then
			scoop install "$APP"
		fi
	done
fi

chezmoi age decrypt ~/.local/share/chezmoi/home/dot_config/chezmoi/.age.key --output ~/.config/chezmoi/age.key --passphrase
