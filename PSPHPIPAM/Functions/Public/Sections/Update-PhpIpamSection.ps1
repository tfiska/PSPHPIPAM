<#
.SYNOPSIS
    Update PhpIpamSection
.DESCRIPTION
    Update PhpIpamSection
.EXAMPLE
    PS C:\> Update-PhpIpamSection -Params @{id=37;description="test"}
.INPUTS
    Params (hashtable) which contains section info should be provided
.OUTPUTS
    Output (if any)
.NOTES

#>
function Update-PhpIpamSection{
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
        $r=Invoke-PhpIpamExecute -method patch -controller sections -params $Params -PhpIpamSession $PhpIpamSession -ErrorAction stop
        if($r -and $r.success){
            Get-PhpIpamSection -ID $Params['id'] -PhpIpamSession $PhpIpamSession
        }
    }
    END{

    }
}


Export-ModuleMember -Function Update-PhpIpamSection




