# Customized PowerShell Prompt
Supports PowerShell 5.* and 7.*
## Like Linux ~
1. Replaces the path separator "\\" with "/".
2. When current directory is the home directory, displays "~".
3. When executed by the super user, displays "#", otherwise displays "$".
4. Assigns tab completion to complete (works similarly to bash's complete).
5. Loads .ps1 scripts under the [./Autoload/](https://github.com/c-nao27/powershell-profile/tree/master/AutoLoad) directory.
