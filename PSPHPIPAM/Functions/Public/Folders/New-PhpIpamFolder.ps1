<#
.SYNOPSIS
    Create PhpIpamfolder
.DESCRIPTION
    Create PhpIpamfolder
.EXAMPLE
    # Create an folder and get folder info using pipeline
    PS C:\> New-PhpIpamfolder -Param @{"name"="folder3"}|get-PhpIpamfolder

    id               : 10
    name             : folder3
    description      :
    masterfolder    : 0
    permissions      :
    strictMode       : 1
    subnetOrdering   :
    order            :
    editDate         :
    showVLAN         : 0
    showVRF          : 0
    showSupernetOnly : 0
    DNS              :
.INPUTS
    Inputs (if any)
.OUTPUTS
    Output (if any)
.NOTES
    General notes
#>
function New-PhpIpamfolder{

    [cmdletBinding()]
    Param(
        [parameter(Mandatory=$true,ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true,Position=0)]
        [validateScript({$_ -is [system.collections.hashtable]})]
        $Params=@{},
        [parameter(mandatory = $false)][hashtable]$PhpIpamSession=@{}
    )
    begin{
        if ( -not $Params.isFolder) {$Params.Add("isFolder",1)}

    }
    process{
        $r=$(Invoke-PhpIpamExecute -method post -ContentType "application/json" -controller folders -params $Params -PhpIpamSession $PhpIpamSession)
        if($r -and $r.success -and $r.id){
            Get-PhpIpamfolderByID -id $r.id -PhpIpamSession $PhpIpamSession
        } else {$r}
       
    }
    end{

    }
}

Export-ModuleMember -Function New-PhpIpamfolder
