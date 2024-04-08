function Get-PhpIpamSubnets{
    [cmdletbinding()]
    param(
        [parameter(mandatory = $false)]
        [hashtable]$PhpIpamSession=@{}
    )
    $r=Invoke-PhpIpamExecute -method get -controller subnets -ContentType "application/json" -PhpIpamSession $PhpIpamSession -ErrorAction Continue
    Resolve-PhpIpamExecuteResult -result $r
}
new-alias -Name Get-PhpIpamAllSubnets -Value Get-PhpIpamSubnets
Export-ModuleMember -Function Get-PhpIpamSubnets -Alias Get-PhpIpamAllSubnets
