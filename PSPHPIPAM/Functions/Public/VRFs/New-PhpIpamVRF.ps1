<#
.SYNOPSIS
    Create PhpIpamvrf
.DESCRIPTION
    Create PhpIpamvrf
.EXAMPLE
    # Create an vrf and get vrf info using pipeline
    PS C:\> New-PhpIpamvrf -Param @{"name"="vrf3"}|get-PhpIpamvrf

    id               : 10
    name             : vrf3
    description      :
    mastervrf    : 0
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
function New-PhpIpamvrf{

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
        $r = $(Invoke-PhpIpamExecute -ContentType "application/json" -method post -controller vrf -PhpIpamSession $PhpIpamSession -params $Params)
        if ($r -and $r.success) {
            if ($r.id) {
                Get-PhpIpamvrfByID -id $r.id  -PhpIpamSession $PhpIpamSession
            }
        } elseif ($r) {
            Write-Error $r
        } else { Write-Error "`$r is empty for params: $(($params | ConvertTo-Json)  -replace '(^\s+|\s+$)','' -replace '\s+',' '  )"}
    }
    end{

    }
}

Export-ModuleMember -Function New-PhpIpamvrf
