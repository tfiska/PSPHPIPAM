function Get-PhpIpamvrfs{
    [cmdletbinding()]
    param(
        [parameter(mandatory = $false)]
        [hashtable]$PhpIpamSession=@{}
    
    )
    $r=Invoke-PhpIpamExecute -method get -controller vrf  -PhpIpamSession $PhpIpamSession
    Resolve-PhpIpamExecuteResult -result $r
}

New-Alias -Name Get-PhpIpamAllvrfs -Value Get-PhpIpamvrfs
Export-ModuleMember -Function Get-PhpIpamvrfs -Alias Get-PhpIpamAllvrfs
