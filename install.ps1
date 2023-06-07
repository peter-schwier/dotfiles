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

~/.local/miniconda3/Scripts/conda.exe install --yes --override-channels --channel conda-forge git

# Set the path so that ~/.dotnet/tools/pwsh.exe will run correctly
$env:DOTNET_ROOT = "${env:UserProfile}\.dotnet"
$env:Path = "${env:UserProfile}\.dotnet;" + $env:Path
$env:Path = "${env:UserProfile}\.dotnet\tools;" + $env:Path

if (-not(Test-Path -Path (Join-Path (Resolve-Path ~) .local/bin/chezmoi.exe) -PathType Leaf)) { 
    # Install chezmoi.exe
    '$params = "-BinDir ~/.local/bin init --apply peter-schwier"', (irm -useb https://get.chezmoi.io/ps1) | powershell -c -
}
