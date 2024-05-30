<#
.SYNOPSIS
    Create PhpIpamdevice
.DESCRIPTION
    Create PhpIpamdevice
.EXAMPLE
    # Create an device and get device info using pipeline
    PS C:\> New-PhpIpamdevice -Param @{"name"="device3"}|get-PhpIpamdevice

    id               : 10
    name             : device3
    description      :
    masterdevice    : 0
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
function New-PhpIpamdevice{

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
        $r=Invoke-PhpIpamExecute -method post -controller devices -params $Params -PhpIpamSession $PhpIpamSession
        if($r.success){
                Get-PhpIpamdeviceByID -id $r.id -PhpIpamSession $PhpIpamSession
        }
    }
    end{

    }
}

Export-ModuleMember -Function New-PhpIpamdevice
