IF EXIST %UserProfile%\.dotnet\dotnet.exe GOTO :EOF
powershell -NoProfile -ExecutionPolicy Unrestricted -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; &([scriptblock]::Create((Invoke-WebRequest -UseBasicParsing 'https://dot.net/v1/dotnet-install.ps1'))) -InstallDir '~/.dotnet' -Channel STS -Version latest -Verbose"
:EOF
