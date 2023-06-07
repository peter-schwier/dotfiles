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
    
    # Load the conda environment into the current shell
    # This is the code copied out of Documents/PowerShell/profile.ps1
    (& ~/.local/miniconda3/Scripts/conda.exe "shell.powershell" "hook") | Out-String | ?{$_} | Invoke-Expression
}

# Install condaforge based applications
~/.local/miniconda3/Scripts/conda.exe install `
    --yes --override-channels --channel conda-forge `
    git `
    rclone `
    syncthing `

if (-not(Test-Path -Path (Join-Path (Resolve-Path ~) .dotnet/dotnet.exe) -PathType Leaf)) { 
    # Install dotnet
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; &([scriptblock]::Create((Invoke-WebRequest -UseBasicParsing 'https://dot.net/v1/dotnet-install.ps1'))) -InstallDir '~/.dotnet' -Channel STS -Version latest -Verbose
}

if (-not(Test-Path -Path (Join-Path (Resolve-Path ~) .dotnet/tools/pwsh.exe) -PathType Leaf)) { 
    # Install PowerShell Core
    ~/.dotnet/dotnet tool install --global PowerShell
}

# Set the path so that ~/.dotnet/tools/pwsh.exe will run correctly
$env:DOTNET_ROOT = "${env:UserProfile}\.dotnet"
$env:Path = "${env:UserProfile}\.dotnet;" + $env:Path
$env:Path = "${env:UserProfile}\.dotnet\tools;" + $env:Path

~/.dotnet/tools/pwsh.exe -NoProfile -ExecutionPolicy Unrestricted -Command "Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser"


if (-not(Test-Path -Path (Join-Path (Resolve-Path ~) .local/bin/chezmoi.exe) -PathType Leaf)) { 
    # Install chezmoi.exe
    '$params = "-BinDir ~/.local/bin init peter-schwier"', (irm -useb https://get.chezmoi.io/ps1) | powershell -c -
}

# Apply the config files, also installing wezterm and other zip based deployments
~/.local/bin/chezmoi.exe apply

# Only add the shortcut after chezmoi runs to install wezterm

$shortcutPath = Join-Path (Resolve-Path ~) Desktop/WezTerm.lnk
$shortcutTarget = Join-Path (Resolve-Path ~) .local/wezterm/wezterm-gui.exe

if (-not(Test-Path -Path $shortcutPath -PathType Leaf)) { 
    $ws = New-Object -ComObject WScript.Shell
    $s = $ws.CreateShortcut($shortcutPath)
    $s.TargetPath = $shortcutTarget
    #$s.Arguments = (Join-Path (Resolve-Path ~) .dotnet/tools/pwsh.exe)
    $s.WorkingDirectory = (Resolve-Path ~)
    $s.Description = "WezTerm Terminal Multiplexer"
    $s.IconLocation = $shortcutTarget
    $s.WindowStyle = 3 # 3=Maximized, 7=Minimized, 4=Normal
    $s.Save()
}
