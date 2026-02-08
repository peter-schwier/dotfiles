# Peter's Digital Workspace

I'm organizing the tools I use in my personal and work life to be consistant across platforms.  I want to remain compatable with my employer's "Software Advisory Register" (that says if the software has a license compatable with enterprise use, and doesn't include malware) so I won't have to worry about differing configurations on my personal vs professional devices.

## Software Advisory Register

I use several Unicode symbols to keep track of the approved, rejected, unreviewed status of these tools in my employer's "Software Advisory Register".

* ☑ Approved
* ☒ Rejected (Usually includes a reason listed.)
* ☐ Unreviewed

## Core Tools

These are the core technologies I plan to use for data storage and replication.  Every device I use should be able to support all of these, even if some devices don't have it installed.

* [Git](https://git-scm.com/) ☑ for source control of dotfiles and public file hosting. 
    * Public Websites: [GitHub Pages](https://docs.github.com/en/pages) for hosting my public knowledge base and consider moving [My Website](https://www.schwier.us).
    * Android's [Termux](https://f-droid.org/en/packages/com.termux/) ☐: [pkg install git](https://github.com/termux/termux-packages/tree/master/packages/git) ☑
    * Bazzite: TODO
    * iPhone/iPad: [Working Copy](https://workingcopyapp.com/)
    * Windows: [Git for Windows](https://gitforwindows.org/) ☑ via [Scoop](https://scoop.sh/) ☐
* [KeePass](https://keepass.info/) for password management that is private to my devices.
    * Android: [KeePass2Android](https://github.com/PhilippC/keepass2android) ☐
    * Bazzite: [KeePassXC](https://keepassxc.org/) ☑
    * iPhone/iPad: [KeePassium](https://keepassium.com/) ☑ (Free edition only for enterprise device.)
    * Windows: [KeePassXC](https://keepassxc.org/) ☑ via [Scoop](https://scoop.sh/) ☐
* [Posix Shell](https://en.wikipedia.org/wiki/Almquist_shell) 
    * Android's [Termux](https://f-droid.org/en/packages/com.termux/) ☐: [Bash](https://www.gnu.org/software/bash/)
    * Bazzite: [Bash](https://www.gnu.org/software/bash/)
    * iPhone/iPad: [Dash](https://git.kernel.org/pub/scm/utils/dash/dash.git) via [a-Shell](https://github.com/holzschu/a-shell) ☐
    * Windows: [Bash](https://www.gnu.org/software/bash/) via [Git for Windows](https://gitforwindows.org/) ☑ via [Scoop](https://scoop.sh/) ☐
* [Syncthing](https://syncthing.net/) ☑ for file replication between my devices without having a dedicated cloud host.
    * Android's [Termux](https://f-droid.org/en/packages/com.termux/) ☐: [pkg install syncthing](https://github.com/termux/termux-packages/tree/master/packages/syncthing) ☑
    * Bazzite: TODO
    * iPhone/iPad: [Möbius Sync](https://www.mobiussync.com/) ☐
    * Windows: [Syncthing](https://syncthing.net/) ☑ via [Scoop](https://scoop.sh/) ☐
* [TiddlyWiki](https://tiddlywiki.com/) ☑ for knowledge store and its [Interwingularity](https://en.wikipedia.org/wiki/Intertwingularity).
    * Android's [Termux](https://f-droid.org/en/packages/com.termux/) ☐: [pkg install rclone](https://github.com/termux/termux-packages/tree/master/packages/rclone) ☑ for WebDav hosting
    * Bazzite: TODO
    * iPhone/iPad: [Quine](https://apps.apple.com/us/app/quine/id1450128957) ☐
    * Windows: [RClone](https://rclone.org/commands/rclone_serve_webdav/) ☑ for WebDav hosting
* [Vim](https://www.vim.org/) for a text editor
    * Android's [Termux](https://f-droid.org/en/packages/com.termux/) ☐: TODO
    * Bazzite: TODO
    * iPhone/iPad: Vim via [a-Shell](https://github.com/holzschu/a-shell) ☐
    * Windows: [Git for Windows](https://gitforwindows.org/) ☑ via [Scoop](https://scoop.sh/) ☐


# Peter's dotfiles

Managed by [Chezmoi](https://www.chezmoi.io/).

* Install applications using platform specific package managers.

    * On Windows, use [[Scoop|https://scoop.sh/]].
        * Install Scoop using the command `powershell.exe -NoLogo -NoProfile -NonInteractive -ExecutionPolicy RemoteSigned -Command "& { Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression }"`, then close that command prompt and open a new one.
        * Add the extras bucket using the command `scoop bucket add extras`.
        * Install appliactions using the command `scoop install main/chezmoi main/git main/pueue extras/keepassxc main/rclone main/pwsh main/syncthing`.
    * On Termux, 'pkg install chezmoi which'


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

* https://github.com/bkuhlmann/dotfiles/tree/main/lib/templates/.config
* https://github.com/joshsurber/.files/tree/master/bash/.bash
* https://github.com/daler/dotfiles/tree/master


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


# Version 2.0

I'm thinking about migrating away from chezmoi to a custom bash script based setup. Because [a-Shell](https://github.com/holzschu/a-shell) would not let me install Chemzoi, but does run dash.

Turns out that I can use a here document to feed a generated script into the `sh` command. As an example:

``` t.txt
Hello, $(whoami) on this wonderful $(date) day.
/bin/sh*
```

```sh t.sh
#! /bin/sh

sh <<END_OF_FILE
cat <<EOF
$(cat t.txt)
EOF
END_OF_FILE
```

I will need to come up with better heredoc strings, but this would let me create template files that just use standard posix shell script replacements.


