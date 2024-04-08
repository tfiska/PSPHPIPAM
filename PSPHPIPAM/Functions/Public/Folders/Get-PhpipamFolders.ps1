function Get-PhpIpamFolders{
    [cmdletbinding()]
    param(
        [parameter(mandatory = $false)]
        [hashtable]$PhpIpamSession=@{}
    )
    $r=Invoke-PhpIpamExecute -method get -controller folders -PhpIpamSession $PhpIpamSession
    Resolve-PhpIpamExecuteResult -result $r
}



New-Alias -Name Get-PhpIpamAllFolders -Value Get-PhpIpamFolders
Export-ModuleMember -Function Get-PhpIpamFolders -Alias Get-PhpIpamAllFolders
