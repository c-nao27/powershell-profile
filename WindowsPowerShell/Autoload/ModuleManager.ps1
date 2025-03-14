$modules = "DockerCompletion"

# Import from local
Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1

Write-Output "Checking modules..."
foreach ($module in $modules) {
    $installed = Get-Module -ListAvailable -Name $module | Sort-Object Version -Descending | Select-Object -First 1

    if (-not $installed) {
        Write-Output "Installing $module..."
        Install-Module -Name $module -Scope CurrentUser -Force
    } else {
        #version check
        $latest = Find-Module -Name $module -ErrorAction SilentlyContinue
        if ($latest.Version -gt $installed.Version) {
            Write-Output "Updating $module from version $($installed.Version) to $($latest.Version)..."
            # clean install
            Uninstall-Module -Name $module -Force
            Install-Module -Name $module -Scope CurrentUser -Force
        }
    }
    Import-Module $module -Force
}

# uninstall module
foreach ($module in Get-InstalledModule) {
    if ($module.Name -notin $modules) {
        Write-Output "Uninstalling $($module.Name)..."
        Uninstall-Module -Name $module.Name -Force
    }
}
Get-Module | Select-Object @{Name="Imported module"; Expression={$_.Name}}, Version
