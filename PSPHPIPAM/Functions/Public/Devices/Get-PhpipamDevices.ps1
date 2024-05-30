function Get-PhpIpamdevices{
    [cmdletbinding()]
    param(
        [parameter(mandatory = $false)]
        [hashtable]$PhpIpamSession=@{}
    
    )
    $r=Invoke-PhpIpamExecute -method get -controller devices  -PhpIpamSession $PhpIpamSession
    [System.Collections.ArrayList]$PhpIpamdevicesReturnArray=New-Object -TypeName System.Collections.ArrayList
    Resolve-PhpIpamExecuteResult -result $r | ForEach-Object {$PhpIpamdevicesReturnArray.add($_) | Out-Null}
    return ,[System.Collections.ArrayList]$PhpIpamdevicesReturnArray
}

New-Alias -Name Get-PhpIpamAlldevices -Value Get-PhpIpamdevices -Force
Export-ModuleMember -Function Get-PhpIpamdevices -Alias Get-PhpIpamAlldevices
