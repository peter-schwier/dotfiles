# dotfiles
Peter's Dotfiles

## Initialization
These are the initializaton steps so that you can check out the repository.

1. Install .NET 6, PowerShell, and Git Credential Manager.
  - On Ubuntu
    ```bash
    sudo apt update && sudo apt install dotnet-sdk-6.0
    dotnet tool install --global PowerShell --version 6 --verbosity detailed
    dotnet tool install -g git-credential-manager
    git-credential-manager configure
    ```

2. Git Clone
   ```bash
   git clone https://github.com/peter-schwier/dotfiles.git
   ```



