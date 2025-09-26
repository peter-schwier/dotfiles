# Core - Git
winget install --source winget --silent --accept-package-agreements --accept-source-agreements Git.Git --override "/VerySilent /NoRestart /o:PathOption=CmdTools /Components=""icons,assoc,assoc_sh,gitlfs""" 

# Core - KeePass
# Install happens in home\.chezmoiexternal.toml.tmpl.

# Core - Syncthing
winget install --source winget --silent --accept-package-agreements --accept-source-agreements Syncthing.Syncthing

# Core - TiddlyWiki
winget install --source winget --silent --accept-package-agreements --accept-source-agreements Rclone.Rclone

# Main - Firefox
winget install --source winget --silent --accept-package-agreements --accept-source-agreements Mozilla.Firefox

# Main - Google Chrome
winget install --source winget --silent --accept-package-agreements --accept-source-agreements Google.Chrome

# Main - PowerShell
# PowerShell 5 preinstalled on all modern windows. Don't bother installing PowerShell 7, it requires admin rights.
# winget install --source winget --silent --accept-package-agreements --accept-source-agreements Microsoft.PowerShell

# Main - Talon Voice
# Install happens in home\.chezmoiexternal.toml.tmpl.

# Extra - Pueue
# Install happens in home\.chezmoiexternal.toml.tmpl.


