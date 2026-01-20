# Peter's dotfiles

Managed by [Chezmoi](https://www.chezmoi.io/).

* Install applications using platform specific package managers.

    * On Windows, use [[Scoop|https://scoop.sh/]].
        * Install Scoop using the command `powershell.exe -NoLogo -NoProfile -NonInteractive -ExecutionPolicy RemoteSigned -Command "& { Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression }"`, then close that command prompt and open a new one.
        * Add the extras bucket using the command `scoop bucket add extras`.
        * Install appliactions using the command `scoop install main/chezmoi main/git main/pueue extras/keepassxc main/rclone main/pwsh main/syncthing`.


* Initialize chezmoi using `chezmoi init peter-schwier`.

* Install the default `~/.config/chezmoi/age.key` using the command `chezmoi age decrypt --passphrase ~/.local/share/chezmoi/home/dot_config/chezmoi/.age.key --output ~/.config/chezmoi/age.key`.

* Then actually apply things using the command `chezmoi apply`. Do this after setting the `~/.config/chezmoi/age.key` so that encrypted files will decrypt correctly.

# TODO

* Fix `home\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\startup.bat - Shortcut.lnk` to work on different windows machines.

* Swap out from Syncthing, to RClone based bisync in a star configuration using my Google Drive.

This works for calculating forward 5 minutes:

```sh
date -D "%s" -d $(($(date +%s) + (5 * 60) )) -Iseconds
```

https://github.com/sgleizes/xsh

# Documentation

* `.chezmoiroot` - As per https://www.chezmoi.io/reference/special-files/chezmoiroot/, treat the `home` folder as the root folder for parsing `chezmoi` file.  This allows me to re-use the dotfiles repo for other things later, if need be.
* `home/.chezmoi.toml.tmpl` - As per https://www.chezmoi.io/reference/special-files/chezmoi-format-tmpl/, this is the first file parsed, to create the data set for all other templates.
* `home/.chezmoitemplates/*` - As per https://www.chezmoi.io/reference/special-directories/chezmoitemplates/ these are templates that I can import in other files using `{{ template "filename" . }}`.
* `home/.chezmoiignore.tmpl` - As per https://www.chezmoi.io/reference/special-files/chezmoiignore/, these are files that should be ignored per machine.
* `home/.chezmoiexternal.toml.tmpl` - As per https://www.chezmoi.io/reference/special-files/chezmoiexternal-format/, this is for pulling in external repositories or archives per machine.
* `home/.chezmoiscripts/**` - As per https://www.chezmoi.io/reference/special-directories/chezmoiscripts/, these are change scripts that run according to their [[attributes|https://www.chezmoi.io/reference/source-state-attributes/]].
* `home/**[.tmpl]` - All other files are loaded, based on their [[attributes|https://www.chezmoi.io/reference/source-state-attributes/]] into the user's home folder.

## XDG

https://specifications.freedesktop.org/basedir/latest/

The `~/.local/bin/` should be in the local path.  This is where I install `chezmoi` to, and the other single file command line applications.

* `$XDG_DATA_HOME` should be `~/.local/share/`, this is where chezmoi checks out the git repo to. Like that, it is a persistant data folder, for interaction, but not configuration.
* `$XDG_CONFIG_HOME` should be `~/.config/`, this is where chezmoi puts its configuration file. Like that, it is a persistant config storage location, things in here should change when the user chooses to, not automatically.
* `$XDG_STATE_HOME` should be `~/.local/state/`, this is where local state information should remain. I will be using this for keeping track of when I start/stop scripts.