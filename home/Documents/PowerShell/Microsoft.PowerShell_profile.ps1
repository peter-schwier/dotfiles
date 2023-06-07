
$env:DOTNET_ROOT = "${env:UserProfile}\.dotnet"
$env:Path = "${env:UserProfile}\.dotnet;" + $env:Path
$env:Path = "${env:UserProfile}\.dotnet\tools;" + $env:Path
