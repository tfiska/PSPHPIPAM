<#
.SYNOPSIS
    Creates new subnet
.DESCRIPTION
    Creates new subnet
.EXAMPLE
    PS C:\> New-PhpIpamSubnet -Params @{sectionId=1;subnet='192.168.10.0';mask=24}
    Create an subnet 192.168.10.0/24 in section 1
.INPUTS
    Hashtable contains subnet infos
.OUTPUTS
    Output (if any)
.NOTES
    General notes
#>
function New-PhpIpamSubnet {

    [cmdletBinding()]
    Param(
        [parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, Position = 0)]
        [validateScript( { $_ -is [system.collections.hashtable] })]
        $Params,
        [parameter(mandatory = $false)][hashtable]$PhpIpamSession=@{},
        [parameter(mandatory = $false)][switch]$force_section_no_strictMode
    )
    begin {

    }
    process {
        #$Params.masterSubnetId
        
        $r = Invoke-PhpIpamExecute -method post -ContentType "application/json" -controller subnets -params $Params -PhpIpamSession $PhpIpamSession
        if($r -and $r.message -match "^Subnet overlaps with " -and $force_section_no_strictMode) {
            $OldSection=Get-PhpIpamSectionByID -PhpIpamSession  $PhpIpamSession -id $Params.sectionId
            $Section=Update-PhpIpamSection -PhpIpamSession  $PhpIpamSession -Params @{id=$Params.sectionId;strictMode=0}
            $r = Invoke-PhpIpamExecute -method post -ContentType "application/json" -controller subnets -params $Params -PhpIpamSession $PhpIpamSession
            $Section=Update-PhpIpamSection -PhpIpamSession  $PhpIpamSession -Params @{id=$Section.id;strictMode=$OldSection.strictMode}
            
        }
        if ($r -and $r.success) {
            if ($r.id) {
                $ReturnData=Get-PhpIpamSubnetByID -id $r.id  -PhpIpamSession $PhpIpamSession
            }
        } else {
            write-warning "New-PhpIpamSubnet returned : `"$($($r | ConvertTo-Json )  -replace '(^\s+|\s+$)','' -replace '\s+',' ')`" Params = $($($params | ConvertTo-Json )  -replace '(^\s+|\s+$)','' -replace '\s+',' ')" 
            if ([bool]$r){
              Write-Error $r
            }
        }
    }
    end {
        Return $ReturnData
    }
}

Export-ModuleMember -Function New-PhpIpamSubnet
