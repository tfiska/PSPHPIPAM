<#
.SYNOPSIS
    Update PhpIpamdevice
.DESCRIPTION
    Update PhpIpamdevice
.EXAMPLE
    PS C:\> Update-PhpIpamdevice -Params @{id=37;description="test"}
.INPUTS
    Params (hashtable) which contains device info should be provided
.OUTPUTS
    Output (if any)
.NOTES

#>
function Update-PhpIpamdevice{
    [cmdletBinding()]
    param(
        [parameter(Mandatory=$true,ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true,Position=0)]
        [validatescript({$_ -is [hashtable] -or $_ -is [psCustomObject]})]
        $Params,

        [parameter(mandatory = $false)]
        [hashtable]$PhpIpamSession=@{}
    )
    BEGIN{

    }
    PROCESS{
        $r=Invoke-PhpIpamExecute -method patch  -ContentType "application/json;charset=UTF-8" -controller devices -params $Params -PhpIpamSession $PhpIpamSession -ErrorAction stop
        if($r -and $r.success){
            Get-PhpIpamdevice -ID $Params['id'] -PhpIpamSession $PhpIpamSession
        } else {$r}
    }
    END{

    }
}


Export-ModuleMember -Function Update-PhpIpamdevice




