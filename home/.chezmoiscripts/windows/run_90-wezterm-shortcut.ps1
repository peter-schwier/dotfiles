
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
