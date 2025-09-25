# Peter's dotfiles

Managed by [Chezmoi](https://www.chezmoi.io/)

Use the [One line binary install](https://www.chezmoi.io/install/#one-line-binary-install) with the `-b .local/bin -- init --apply peter-schwier` arguments to initialize with this repo and install into `~/.local/bin`.

* PowerShell: `iex "&{$(irm 'https://get.chezmoi.io/ps1')} -b .local/bin -- init --apply peter-schwier"`
* bash curl: `sh -c "$(curl -fsLS get.chezmoi.io)" -- -b .local/bin init --apply $GITHUB_USERNAME`

# TODO

1. Fix `home\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\startup.bat - Shortcut.lnk` to work on different windows machines.
2. 