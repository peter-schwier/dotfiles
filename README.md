# Peter's dotfiles

Managed by Chezmoi

## Install

### On Windows

```powershell
powershell -NoProfile -ExecutionPolicy Unrestricted -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; &([scriptblock]::Create((Invoke-WebRequest -UseBasicParsing 'https://raw.githubusercontent.com/peter-schwier/dotfiles/main/install.ps1')))"

```

```powershell
'$params = "-BinDir ~/.local/bin" init --apply peter-schwier', (iwr https://get.chezmoi.io/ps1).Content | powershell -c -
```

### On Linux

```bash
bash -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin init --apply peter-schwier
```
or
```bash
bash -c "$(wget -qO- get.chezmoi.io)" -- -b $HOME/.local/bin init --apply peter-schwier
```

## TODO

Pull more parts from https://github.com/twpayne/dotfiles/
