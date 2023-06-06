
if (-not(Test-Path -Path (Join-Path (Resolve-Path ~) .local/wezterm/wezterm-gui.exe) -PathType Leaf)) { 
    # Install WezTerm if it is missing.
    rmdir -Force ~/.local/wezterm
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -UseBasicParsing 'https://github.com/wez/wezterm/releases/download/20230408-112425-69ae8472/WezTerm-windows-20230408-112425-69ae8472.zip' -OutFile WezTerm-windows-20230408-112425-69ae8472.zip
    Start-Process -FilePath WezTerm-windows-20230408-112425-69ae8472.zip -NoNewWindow -Wait -ArgumentList @("/InstallationType=JustMe","/AddToPath=0","/RegisterPython=0","/D=" + (Join-Path (Resolve-Path ~) .local/miniconda3))
    Expand-Archive -Path WezTerm-windows-20230408-112425-69ae8472.zip -DestinationPath (Join-Path (Resolve-Path ~) .local/wezterm)
    rm WezTerm-windows-20230408-112425-69ae8472.zip
}

# Install the WezTerm shortcut on the desktop.

$shortcutPath = Join-Path (Resolve-Path ~) Desktop/WezTerm.lnk
$shortcutTarget = Join-Path (Resolve-Path ~) .local/wezterm/wezterm-gui.exe

if (-not(Test-Path -Path $shortcutPath -PathType Leaf)) { 
    $ws = New-Object -ComObject WScript.Shell
    $s = $ws.CreateShortcut($shortcutPath)
    $s.TargetPath = $shortcutTarget
    $s.Arguments = (Join-Path (Resolve-Path ~) .dotnet/tools/pwsh.exe)
    $s.WorkingDirectory = (Resolve-Path ~)
    $s.Description = "WezTerm Terminal Multiplexer"
    $s.IconLocation = $shortcutTarget
    $s.WindowStyle = 3 # 3=Maximized, 7=Minimized, 4=Normal
    $s.Save()
}

if (-not(Test-Path -Path (Join-Path (Resolve-Path ~) .local/miniconda3/condabin/conda.bat) -PathType Leaf)) { 
    # First, Install MiniConda3 into a local folder
    rmdir -Force ~/.local/miniconda3
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -UseBasicParsing 'https://repo.anaconda.com/miniconda/Miniconda3-latest-Windows-x86_64.exe' -OutFile Miniconda3-latest-Windows-x86_64.exe
    Start-Process -FilePath Miniconda3-latest-Windows-x86_64.exe -NoNewWindow -Wait -ArgumentList @(
        "/InstallationType=JustMe",
        "/AddToPath=0",
        "/RegisterPython=0",
        "/S",
        [System.String]::Concat("/D=", (Join-Path (Resolve-Path ~) .local/miniconda3))
    )
    rm Miniconda3-latest-Windows-x86_64.exe

    # Second, Initialize MiniConda3
    ~/.local/miniconda3/Scripts/conda.exe init
    
    (& ~/.local/miniconda3/Scripts/conda.exe "shell.powershell" "hook") | Out-String | ?{$_} | Invoke-Expression
}

~/.local/miniconda3/Scripts/conda.exe install --yes --override-channels --channel conda-forge git rclone syncthing


if (-not(Test-Path -Path (Join-Path (Resolve-Path ~) .local/bin/chezmoi.exe) -PathType Leaf)) { 
    # Install chezmoi.exe
    '$params = "-BinDir ~/.local/bin" init --apply peter-schwier', (iwr https://get.chezmoi.io/ps1).Content | powershell -c -
}
