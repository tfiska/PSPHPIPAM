function Get-PhpIpamdevice_types{
    [cmdletbinding()]
    param(
        [parameter(mandatory = $false)]
        [hashtable]$PhpIpamSession=@{}
    
    )
    $r=Invoke-PhpIpamExecute -method get -controller tools -identifiers device_types -PhpIpamSession $PhpIpamSession
    Resolve-PhpIpamExecuteResult -result $r
}



New-Alias -Name Get-PhpIpamAlldevice_types -Value Get-PhpIpamdevice_types
Export-ModuleMember -Function Get-PhpIpamdevice_types -Alias Get-PhpIpamAlldevice_types
    
