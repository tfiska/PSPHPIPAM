function Get-PhpIpamvlans{
    [cmdletbinding()]
    param(
        [parameter(mandatory = $false)]
        [hashtable]$PhpIpamSession=@{}
    
    )
    $r=Invoke-PhpIpamExecute -method get -controller vlans  -PhpIpamSession $PhpIpamSession
    Resolve-PhpIpamExecuteResult -result $r
}

New-Alias -Name Get-PhpIpamAllvlans -Value Get-PhpIpamvlans
Export-ModuleMember -Function Get-PhpIpamvlans -Alias Get-PhpIpamAllvlans
