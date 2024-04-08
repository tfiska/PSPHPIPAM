function Get-PhpIpamNATs{
    [cmdletbinding()]
    param(
        [parameter(mandatory = $false)]
        [hashtable]$PhpIpamSession=@{}
    
    )
    $r=Invoke-PhpIpamExecute -method get -controller tools -identifiers nat -PhpIpamSession $PhpIpamSession
    Resolve-PhpIpamExecuteResult -result $r
}



New-Alias -Name Get-PhpIpamAllNATs -Value Get-PhpIpamNATs
Export-ModuleMember -Function Get-PhpIpamNATs -Alias Get-PhpIpamAllNATs
    
