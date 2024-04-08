function Get-PhpIpamLocations{
    [cmdletbinding()]
    param(
        [parameter(mandatory = $false)]
        [hashtable]$PhpIpamSession=@{}
    
    )
    $r=Invoke-PhpIpamExecute -method get -controller tools -identifiers locations -PhpIpamSession $PhpIpamSession
    Resolve-PhpIpamExecuteResult -result $r
}



New-Alias -Name Get-PhpIpamAllLocations -Value Get-PhpIpamLocations
Export-ModuleMember -Function Get-PhpIpamLocations -Alias Get-PhpIpamAllLocations
    
