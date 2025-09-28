:: Core - Git
winget install --source winget --scope user --silent --accept-package-agreements --accept-source-agreements --exact --id Git.MinGit
:: Using Git.MinGit, because Git.Git required UAC elevation on my personal Windows 11 Pro machine.

:: Core - KeePass
:: Install happens in home\.chezmoiexternal.toml.tmpl.

:: Core - Syncthing
winget install --source winget --scope user --silent --accept-package-agreements --accept-source-agreements --exact --id Syncthing.Syncthing

:: Core - TiddlyWiki
winget install --source winget --scope user --silent --accept-package-agreements --accept-source-agreements --exact --id Rclone.Rclone

:: Main - Firefox
winget install --source winget --scope user --silent --accept-package-agreements --accept-source-agreements --exact --id Mozilla.Firefox

:: Main - Google Chrome
:: winget install --source winget --scope user --silent --accept-package-agreements --accept-source-agreements --exact --id Google.Chrome
:: Requires UAC elevation on my personal Windows 11 Pro machine.

:: Main - PowerShell
:: PowerShell 5 preinstalled on all modern windows. Don't bother installing PowerShell 7, it requires admin rights.
:: winget install --source winget --silent --accept-package-agreements --accept-source-agreements Microsoft.PowerShell

:: Main - Talon Voice
:: Install happens in home\.chezmoiexternal.toml.tmpl.

:: Extra - Pueue
:: Install happens in home\.chezmoiexternal.toml.tmpl.

:: To stop chezmoi from complaining about a bad return code.
@ECHO.