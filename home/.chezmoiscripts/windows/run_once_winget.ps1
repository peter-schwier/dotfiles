winget install Git.Git --silent --accept-package-agreements --accept-source-agreements --override "/VerySilent /NoRestart /o:PathOption=CmdTools /Components=""icons,assoc,assoc_sh,gitlfs"""
winget install --source winget --exact --id JohnMacFarlane.Pandoc

# # browsers
# winget install Google.Chrome --silent --accept-package-agreements --accept-source-agreements
# winget install Mozilla.Firefox --silent --accept-package-agreements --accept-source-agreements

# # dev tools and frameworks
# winget install Microsoft.PowerShell --silent --accept-package-agreements --accept-source-agreements
# winget install Vim.Vim --silent --accept-package-agreements --accept-source-agreements
