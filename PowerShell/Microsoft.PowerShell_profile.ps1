function Prompt {
    $wd = $pwd.ProviderPath.Equals($home) ? "~" : $pwd.ProviderPath.Replace("\", "/")
    $is_admin = [System.Security.Principal.WindowsPrincipal]::new([System.Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)
    Write-Host "$env:username " -ForegroundColor "Green" -NoNewLine
    Write-Host $wd -ForegroundColor "Blue" -NoNewLine
    return $is_admin ? "# " : "$ "
}

# tab補完をcomplete関数(bashのcompleteに似た動作)へ割り当て
Set-PSReadLineKeyHandler -Key TAB -Function Complete

# Autoload
Join-Path ([System.IO.Path]::GetDirectoryName($profile)) Autoload | ls -Filter *.ps1 | % {.$_.FullName}
