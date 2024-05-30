<#
.SYNOPSIS
    Create PhpIpamvlan
.DESCRIPTION
    Create PhpIpamvlan
.EXAMPLE
    # Create an vlan and get vlan info using pipeline
    PS C:\> New-PhpIpamvlan -Param @{"name"="vlan3"}|get-PhpIpamvlan

    id               : 10
    name             : vlan3
    description      :
    mastervlan    : 0
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
function New-PhpIpamvlan{

    [cmdletBinding()]
    Param(
        [parameter(Mandatory=$true,ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true,Position=0)]
        [validateScript({$_ -is [system.collections.hashtable]})]
        $Params=@{},
        [parameter(mandatory = $false)][hashtable]$PhpIpamSession=@{}
    )
    begin{

    }
    process{
        $r=Invoke-PhpIpamExecute -method post -controller vlans -params $Params -PhpIpamSession $PhpIpamSession
        if($r.success){
            Get-PhpIpamvlanByID -id $r.id -PhpIpamSession $PhpIpamSession
        }else {return $r}
        
    }
    end{

    }
}

Export-ModuleMember -Function New-PhpIpamvlan
