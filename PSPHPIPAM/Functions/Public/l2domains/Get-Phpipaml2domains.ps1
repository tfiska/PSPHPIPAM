function Get-PhpIpaml2domains{
    [cmdletbinding()]
    param(
    [parameter(mandatory = $false)]
    [hashtable]$PhpIpamSession=@{}

    )
    $r=Invoke-PhpIpamExecute -method get -controller l2domains -PhpIpamSession $PhpIpamSession
    Resolve-PhpIpamExecuteResult -result $r
}



New-Alias -Name Get-PhpIpamAlll2domains -Value Get-PhpIpaml2domains
Export-ModuleMember -Function Get-PhpIpaml2domains -Alias Get-PhpIpamAlll2domains
    
