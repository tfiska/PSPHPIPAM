function Get-PhpIpamSections{
    [cmdletbinding()]
    param(
        [parameter(mandatory = $false)]
        [hashtable]$PhpIpamSession=@{}
    
    )
    $r=Invoke-PhpIpamExecute -method get -controller sections  -PhpIpamSession $PhpIpamSession
    Resolve-PhpIpamExecuteResult -result $r
}

New-Alias -Name Get-PhpIpamAllSections -Value Get-PhpIpamSections
Export-ModuleMember -Function Get-PhpIpamSections -Alias Get-PhpIpamAllSections
