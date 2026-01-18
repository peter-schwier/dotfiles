PUSHD "%~dp0"
CD ..\..

pueue shutdown

DEL AppData\Local\pueue\pueue.pid

pueued -d

pueue add --immediate rclone serve webdav Syncthing
pueue add --immediate syncthing

keepassxc "Syncthing\Data.KeePass\Peter's Passwords.kdbx"
