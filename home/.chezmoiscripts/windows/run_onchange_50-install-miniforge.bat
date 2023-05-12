IF EXIST %UserProfile%\miniforge3\condabin\conda.bat GOTO :EOF
powershell -NoProfile -ExecutionPolicy unrestricted -Command "mkdir ~/tmp; rmdir -Force ~/miniforge3;"
powershell -NoProfile -ExecutionPolicy unrestricted -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -UseBasicParsing 'https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Windows-x86_64.exe' -OutFile ~/tmp/Miniforge3-Windows-x86_64.exe;"
START /WAIT "" "%UserProfile%\tmp\Miniforge3-Windows-x86_64.exe" /InstallationType=JustMe /S /RegisterPython=0 /AddToPath=0
powershell -NoProfile -ExecutionPolicy unrestricted -Command "rm ~/tmp/Miniforge3-Windows-x86_64.exe"
:EOF
