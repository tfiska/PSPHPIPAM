function Get-PhpIpamUsers{
    [cmdletbinding()]
    param(
        [parameter(mandatory = $false)]
        [hashtable]$PhpIpamSession=@{}
    
    )
    $r=Invoke-PhpIpamExecute -method get -controller user -identifiers all -PhpIpamSession $PhpIpamSession
    Resolve-PhpIpamExecuteResult -result $r
}



New-Alias -Name Get-PhpIpamAllUsers -Value Get-PhpIpamUsers
Export-ModuleMember -Function Get-PhpIpamUsers -Alias Get-PhpIpamAllUsers
    
