<#
.SYNOPSIS
    Update PhpIpamvrf
.DESCRIPTION
    Update PhpIpamvrf
.EXAMPLE
    PS C:\> Update-PhpIpamvrf -Params @{id=37;description="test"}
.INPUTS
    Params (hashtable) which contains vrf info should be provided
.OUTPUTS
    Output (if any)
.NOTES

#>
function Update-PhpIpamvrf{
    [cmdletBinding()]
    param(
        [parameter(Mandatory=$true,ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true,Position=0)]
        [validatescript({$_ -is [hashtable] -or $_ -is [psCustomObject]})]
        $Params,

        [parameter(mandatory = $false)]
        [hashtable]$PhpIpamSession=@{}
    )
    BEGIN{
        if (-not [bool]$Params.id -and [bool]$Params.vrfId -and $Params -is [hashtable]) {$Params.add("id",$Params.vrfId)|out-null}

    }
    PROCESS{
        $r=Invoke-PhpIpamExecute -method patch -ContentType "application/json" -controller vrf -params $Params -PhpIpamSession $PhpIpamSession -ErrorAction stop
        if($r -and $r.success){
            Get-PhpIpamvrf -ID $Params['vrfId'] -PhpIpamSession $PhpIpamSession
        } elseif($r ) {Write-Error $r}
    }
    END{

    }
}


Export-ModuleMember -Function Update-PhpIpamvrf




