function Get-PhpIpamfolders{
    [cmdletbinding()]
    param(
        [parameter(mandatory = $false)]
        [hashtable]$PhpIpamSession=@{}
    
    )
    $r=Invoke-PhpIpamExecute -method get -controller folders  -PhpIpamSession $PhpIpamSession
    Resolve-PhpIpamExecuteResult -result $r
}

New-Alias -Name Get-PhpIpamAllfolders -Value Get-PhpIpamfolders
Export-ModuleMember -Function Get-PhpIpamfolders -Alias Get-PhpIpamAllfolders
