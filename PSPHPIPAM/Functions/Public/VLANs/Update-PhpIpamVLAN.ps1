<#
.SYNOPSIS
    Update PhpIpamvlan
.DESCRIPTION
    Update PhpIpamvlan
.EXAMPLE
    PS C:\> Update-PhpIpamvlan -Params @{id=37;description="test"}
.INPUTS
    Params (hashtable) which contains vlan info should be provided
.OUTPUTS
    Output (if any)
.NOTES

#>
function Update-PhpIpamvlan{
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
        $r=Invoke-PhpIpamExecute -method patch -ContentType "application/json" -controller vlans -params $Params -PhpIpamSession $PhpIpamSession -ErrorAction stop
        if($r -and $r.success){
            Get-PhpIpamvlan -ID $Params['id'] -PhpIpamSession $PhpIpamSession
        }
    }
    END{

    }
}


Export-ModuleMember -Function Update-PhpIpamvlan




