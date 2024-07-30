function ManageRegistry([string]$registryPath, [string]$registryKey, [string]$registryValue, [string]$action = 'install') {

    $registryFqn = "$registryPath\$registryKey"

    if ($action.ToLower() -eq 'install') {

        $_registry = (Get-ItemProperty $registryPath).PSObject.Properties.Name -Contains $registryKey


        if (($_registry -eq $null) -or ($_registry.Length -eq 0)) {
            ManageConsoleOutput -message "Deploying registry: $registryFqn."
            New-ItemProperty $registryPath -Name $registryKey -Value $registryValue
        }
        else {
            ManageConsoleOutput -message "Registry already deployed: $registryFqn."
        }
    
        Get-ItemProperty -Path $registryPath -Name $registryKey
    }

    if ($action.ToLower() -eq 'delete') { 
        Remove-ItemProperty $registryPath -Name $registryKey
    
    }

}