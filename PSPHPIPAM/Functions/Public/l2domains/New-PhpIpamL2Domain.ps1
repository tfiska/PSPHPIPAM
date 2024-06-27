<#
.SYNOPSIS
    Create PhpIpaml2domain
.DESCRIPTION
    Create PhpIpaml2domain
.EXAMPLE
    # Create an l2domain and get l2domain info using pipeline
    PS C:\> New-PhpIpaml2domain -Param @{"name"="l2domain3"}|get-PhpIpaml2domain

    id               : 10
    name             : l2domain3
    description      :
    masterl2domain    : 0
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
function New-PhpIpaml2domain{

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
        $r=Invoke-PhpIpamExecute -ContentType "application/json" -method post -controller l2domains -PhpIpamSession $PhpIpamSession -params $Params
        if($r.success){
            Get-PhpIpaml2domain -PhpIpamSession $PhpIpamSession -ID $r.id
            
        } elseif ([bool]$r) {
            Write-Error $r
        } else {Write-Warning "Nothing returned"}
    }
    end{

    }
}

Export-ModuleMember -Function New-PhpIpaml2domain
