<#
.SYNOPSIS
    Update PhpIpamfolder
.DESCRIPTION
    Update PhpIpamfolder
.EXAMPLE
    PS C:\> Update-PhpIpamfolder -Params @{id=37;description="test"}
.INPUTS
    Params (hashtable) which contains folder info should be provided
.OUTPUTS
    Output (if any)
.NOTES

#>
function Update-PhpIpamfolder{
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
        $r=Invoke-PhpIpamExecute -method patch -ContentType "application/json" -controller folders -params $Params -PhpIpamSession $PhpIpamSession -ErrorAction stop
        if($r -and $r.success){
            Get-PhpIpamfolder -ID $Params['id'] -PhpIpamSession $PhpIpamSession
        }
    }
    END{

    }
}


Export-ModuleMember -Function Update-PhpIpamfolder




