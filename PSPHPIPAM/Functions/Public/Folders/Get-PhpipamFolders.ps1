function Get-PhpIpamFolders{
    [cmdletbinding()]
    param(

    )
    $r=Invoke-PhpIpamExecute -method get -controller folders
    Resolve-PhpIpamExecuteResult -result $r
}



New-Alias -Name Get-PhpIpamAllFolders -Value Get-PhpIpamFolders
Export-ModuleMember -Function Get-PhpIpamFolders -Alias Get-PhpIpamAllFolders
