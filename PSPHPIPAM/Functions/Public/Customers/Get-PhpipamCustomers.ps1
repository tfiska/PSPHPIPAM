function Get-PhpIpamCustomers{
    [cmdletbinding()]
    param(
        [parameter(mandatory = $false)]
        [hashtable]$PhpIpamSession=@{}
    )
    $r=Invoke-PhpIpamExecute -method get -controller tools -identifiers customers -PhpIpamSession $PhpIpamSession
    Resolve-PhpIpamExecuteResult -result $r
}



New-Alias -Name Get-PhpIpamAllCustomers -Value Get-PhpIpamCustomers
Export-ModuleMember -Function Get-PhpIpamCustomers -Alias Get-PhpIpamAllCustomers
    
