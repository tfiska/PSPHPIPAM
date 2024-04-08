function Get-PhpIpamRacks{
    [cmdletbinding()]
    param(
        [parameter(mandatory = $false)]
        [hashtable]$PhpIpamSession=@{}
    
    )
    $r=Invoke-PhpIpamExecute -method get -controller tools -identifiers racks -PhpIpamSession $PhpIpamSession
    Resolve-PhpIpamExecuteResult -result $r
}



New-Alias -Name Get-PhpIpamAllRacks -Value Get-PhpIpamRacks
Export-ModuleMember -Function Get-PhpIpamRacks -Alias Get-PhpIpamAllRacks
    
