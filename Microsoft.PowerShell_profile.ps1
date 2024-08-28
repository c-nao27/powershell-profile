function prompt {
    $wsl_home = "//wsl$/{distribution}/home/{username}"
    $pwd_path = $pwd.ProviderPath.Replace("\", "/")
    $wd = $pwd.ProviderPath.Equals($home) ? "~"
        : $pwd_path.Equals($wsl_home) ? "wsl:~"
        : $pwd_path
    $is_admin = [System.Security.Principal.WindowsPrincipal]::new([System.Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)
    Write-Host "$env:username " -ForegroundColor "Green" -NoNewLine
    Write-Host $wd -ForegroundColor "Blue" -NoNewLine
    if ($wd -gt 30) {
        Write-Host ""
    }
    return $is_admin ? "# " : "$ "
}

# tab補完をComplete関数へ割当（bashのcompleteに似た動作）
Set-PSReadLineKeyHandler -Key TAB -Function Complete

# import module
# Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1

# autoload
ls $home\Documents\PowerShell\autoload\*.ps1 | % {.$_}
