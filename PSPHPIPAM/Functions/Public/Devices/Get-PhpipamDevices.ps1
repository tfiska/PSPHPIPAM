function Get-PhpIpamDevices{
    [cmdletbinding()]
    param(
        [parameter(mandatory = $false)]
        [hashtable]$PhpIpamSession=@{}
    )
    $r=Invoke-PhpIpamExecute -method get -controller devices  -PhpIpamSession $PhpIpamSession
    Resolve-PhpIpamExecuteResult -result $r
}



New-Alias -Name Get-PhpIpamAllDevices -Value Get-PhpIpamDevices
Export-ModuleMember -Function Get-PhpIpamDevices -Alias Get-PhpIpamAllDevices
    
