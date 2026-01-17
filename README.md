# Peter's dotfiles

Managed by [Chezmoi](https://www.chezmoi.io/).

1. Use the [One line binary install](https://www.chezmoi.io/install/#one-line-binary-install) with the `-b .local/bin -- init peter-schwier` arguments to initialize with this repo and install into `~/.local/bin`.

    * PowerShell: `iex "&{$(irm 'https://get.chezmoi.io/ps1')} -b .local/bin -- init peter-schwier"`
    * bash curl: `sh -c "$(curl -fsLS get.chezmoi.io)" -- -b .local/bin init --apply $GITHUB_USERNAME`

2. Install the default `~/.config/chezmoi/age.key` using the command `chezmoi age decrypt --passphrase ~/.local/share/chezmoi/home/dot_config/chezmoi/.age.key --output ~/.config/chezmoi/age.key`.

3. Then actually apply things using the command `chezmoi apply`. Do this after setting the `~/.config/chezmoi/age.key` so that encrypted files will decrypt correctly.

# TODO

1. Fix `home\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\startup.bat - Shortcut.lnk` to work on different windows machines.

# Documentation

1. `.chezmoiroot` - As per https://www.chezmoi.io/reference/special-files/chezmoiroot/, treat the `home` folder as the root folder for parsing `chezmoi` file.  This allows me to re-use the dotfiles repo for other things later, if need be.
2. `home/.chezmoi.toml.tmpl` - As per https://www.chezmoi.io/reference/special-files/chezmoi-format-tmpl/, this is the first file parsed, to create the data set for all other templates.
3. `home/.chezmoitemplates/*` - As per https://www.chezmoi.io/reference/special-directories/chezmoitemplates/ these are templates that I can import in other files using `{{ template "filename" . }}`.
4. `home/.chezmoiignore.tmpl` - As per https://www.chezmoi.io/reference/special-files/chezmoiignore/, these are files that should be ignored per machine.
5. `home/.chezmoiexternal.toml.tmpl` - As per https://www.chezmoi.io/reference/special-files/chezmoiexternal-format/, this is for pulling in external repositories or archives per machine.
6. `home/.chezmoiscripts/**` - As per https://www.chezmoi.io/reference/special-directories/chezmoiscripts/, these are change scripts that run according to their [[attributes|https://www.chezmoi.io/reference/source-state-attributes/]].
7. `home/**[.tmpl]` - All other files are loaded, based on their [[attributes|https://www.chezmoi.io/reference/source-state-attributes/]] into the user's home folder.