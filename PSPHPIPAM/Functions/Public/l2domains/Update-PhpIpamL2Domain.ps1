<#
.SYNOPSIS
    Update PhpIpaml2domain
.DESCRIPTION
    Update PhpIpaml2domain
.EXAMPLE
    PS C:\> Update-PhpIpaml2domain -Params @{id=37;description="test"}
.INPUTS
    Params (hashtable) which contains l2domain info should be provided
.OUTPUTS
    Output (if any)
.NOTES

#>
function Update-PhpIpaml2domain{
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
        $r=Invoke-PhpIpamExecute -method patch -ContentType "application/json" -controller l2domains -params $Params -PhpIpamSession $PhpIpamSession -ErrorAction stop
        if($r -and $r.success){
            Get-PhpIpaml2domain -ID $Params['id'] -PhpIpamSession $PhpIpamSession
        }
    }
    END{

    }
}


Export-ModuleMember -Function Update-PhpIpaml2domain




