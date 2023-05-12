IF EXIST %UserProfile%\.dotnet\tools\pwsh.exe GOTO :EOF
%UserProfile%\.dotnet\dotnet tool install --global PowerShell
:EOF
