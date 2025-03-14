function Prompt {
    $wsl_home = "//wsl$/{distribution}/home/{username}"
    $pwd_path = $pwd.ProviderPath.Replace("\", "/")
    $wd = if ($pwd.ProviderPath.Equals($home)) {"~"}
        elseif ($pwd_path.Equals($wsl_home)) {"wsl:~"}
        else {$pwd_path}
    $is_admin = [System.Security.Principal.WindowsPrincipal]::new([System.Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)
    Write-Host "$env:username " -ForegroundColor "Green" -NoNewLine
    Write-Host $wd -ForegroundColor "Blue" -NoNewLine
    return $(if ($is_admin) {"# "} else {"$ "})
}

# tab補完をcomplete関数(bashのcompleteに似た動作)へ割り当て
Set-PSReadLineKeyHandler -Key TAB -Function Complete

# Autoload
Join-Path ([System.IO.Path]::GetDirectoryName($profile)) Autoload | ls -Filter *.ps1 | % {.$_.FullName}
