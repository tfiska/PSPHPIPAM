function Get-PhpIpamSections{
    [cmdletbinding()]
    param(
        [parameter(mandatory = $false)]
        [hashtable]$PhpIpamSession=@{}
    
    )
    $r=Invoke-PhpIpamExecute -method get -controller sections  -PhpIpamSession $PhpIpamSession
    [System.Collections.ArrayList]$PhpIpamSectionsReturnArray=New-Object -TypeName System.Collections.ArrayList
    Resolve-PhpIpamExecuteResult -result $r | ForEach-Object {$PhpIpamSectionsReturnArray.add($_) | Out-Null}
    return ,[System.Collections.ArrayList]$PhpIpamSectionsReturnArray
}

New-Alias -Name Get-PhpIpamAllSections -Value Get-PhpIpamSections -Force
Export-ModuleMember -Function Get-PhpIpamSections -Alias Get-PhpIpamAllSections
