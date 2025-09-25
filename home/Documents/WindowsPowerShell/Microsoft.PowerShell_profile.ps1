# Set a permanent Environment variable, and reload it into $env
function Set-Environment([String] $variable, [String] $value) {
    Set-ItemProperty "HKCU:\Environment" $variable $value
    # Manually setting Registry entry. SetEnvironmentVariable is too slow because of blocking HWND_BROADCAST
    #[System.Environment]::SetEnvironmentVariable("$variable", "$value","User")
    Invoke-Expression "`$env:${variable} = `"$value`""
}

function Update-EnvPath(
    [String]$PrependPath,
    [String]$AppendPath,
    [String]$RemovePath
) {
    $regexPaths = @()
    if ($PSBoundParameters.Keys -contains 'PrependPath'){
        $regexPaths += [regex]::Escape($PrependPath)
    }
    if ($PSBoundParameters.Keys -contains 'AppendPath'){
        $regexPaths += [regex]::Escape($AppendPath)
    }
    if ($PSBoundParameters.Keys -contains 'RemovePath'){
        $regexPaths += [regex]::Escape($RemovePath)
    }
    $arrPath = $env:Path -split ';'
    foreach ($path in $regexPaths) {
        $arrPath = $arrPath | Where-Object {$_ -notMatch "^$path\\?"}
    }
    if ($PSBoundParameters.Keys -contains 'PrependPath'){
        if (Test-Path $PrependPath) {
            $arrPath = @() + (Resolve-Path $PrependPath) + $arrPath
        }
    }
    if ($PSBoundParameters.Keys -contains 'AppendPath'){
        if (Test-Path $AppendPath) {
            $arrPath = @() + $arrPath + (Resolve-Path $AppendPath)
        }
    }
    $env:Path = $arrPath -join ';'
}

# Basic commands
function which($name) { Get-Command $name -ErrorAction SilentlyContinue | Select-Object Definition }
function touch($file) { "" | Out-File $file -Encoding ASCII }

# Common Editing needs
function Edit-Hosts { Invoke-Expression "sudo $(if($env:EDITOR -ne $null)  {$env:EDITOR } else { 'notepad' }) $env:windir\system32\drivers\etc\hosts" }
function Edit-Profile { Invoke-Expression "$(if($env:EDITOR -ne $null)  {$env:EDITOR } else { 'notepad' }) $profile" }

# Sudo
function sudo() {
    if ($args.Length -eq 1) {
        start-process $args[0] -verb "runAs"
    }
    if ($args.Length -gt 1) {
        start-process $args[0] -ArgumentList $args[1..$args.Length] -verb "runAs"
    }
}

# Easier Navigation: .., ..., ...., ....., and ~
${function:~} = { Set-Location ~ }
# PoSh won't allow ${function:..} because of an invalid path error, so...
${function:Set-ParentLocation} = { Set-Location .. }; Set-Alias ".." Set-ParentLocation
${function:...} = { Set-Location ..\.. }
${function:....} = { Set-Location ..\..\.. }
${function:.....} = { Set-Location ..\..\..\.. }
${function:......} = { Set-Location ..\..\..\..\.. }

# Navigation Shortcuts
${function:apps} = { Set-Location ~\Applications }
${function:sync} = { Set-Location ~\Syncthing }
${function:dt} = { Set-Location ~\Desktop }
${function:docs} = { Set-Location ~\Documents }
${function:dl} = { Set-Location ~\Downloads }

Set-Environment "EDITOR" "code --wait"
Set-Environment "GIT_EDITOR" $Env:EDITOR

Update-EnvPath -PrependPath ~/.local/bin
Update-EnvPath -PrependPath ~/.opt/rclone
