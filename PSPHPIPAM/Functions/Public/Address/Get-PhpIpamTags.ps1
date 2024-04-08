function Get-PhpIpamTags{
    [cmdletbinding()]
    param(
    [parameter(mandatory = $false)]
    [hashtable]$PhpIpamSession=@{}

    )
    $r=Invoke-PhpIpamExecute -method get -controller addresses -identifiers tags -PhpIpamSession $PhpIpamSession
    Resolve-PhpIpamExecuteResult -result $r
}

New-Alias -Name Get-PhpIpamAllTags -Value Get-PhpIpamTags
Export-ModuleMember -Function Get-PhpIpamTags -Alias Get-PhpIpamAllTags
