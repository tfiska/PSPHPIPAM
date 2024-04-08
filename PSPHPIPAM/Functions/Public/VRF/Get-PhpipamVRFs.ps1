function Get-PhpIpamVRFs{
    [cmdletbinding()]
    param(
        [parameter(mandatory = $false)]
        [hashtable]$PhpIpamSession=@{}
    )
    $r=Invoke-PhpIpamExecute -method get -controller vrf -PhpIpamSession $PhpIpamSession
    Resolve-PhpIpamExecuteResult -result $r
}



New-Alias -Name Get-PhpIpamAllVRFs -Value Get-PhpIpamVRFs
Export-ModuleMember -Function Get-PhpIpamVRFs -Alias Get-PhpIpamAllVRFs
    
