function Get-PhpIpamVLANs{
    [cmdletbinding()]
    param(
        [parameter(mandatory = $false)]
        [hashtable]$PhpIpamSession=@{}
    )
    $r=Invoke-PhpIpamExecute -method get -controller vlans -PhpIpamSession $PhpIpamSession
    Resolve-PhpIpamExecuteResult -result $r
}



New-Alias -Name Get-PhpIpamAllVLANs -Value Get-PhpIpamVLANs
Export-ModuleMember -Function Get-PhpIpamVLANs -Alias Get-PhpIpamAllVLANs
    
