<#
.SYNOPSIS
    Remove PhpIpam vrf
.DESCRIPTION
    Remove PhpIpam vrf
.EXAMPLE
    PS C:\> Remove-PhpIpamvrf -ID 20
    PS C:\> Remove-PhpIpamvrf -Name vrf1
    PS C:\> New-PhpIpamvrf -Param @{"name"="vrf5"}|Remove-PhpIpamvrf

.INPUTS
    Inputs (if any)
.OUTPUTS
    Output (if any)
.NOTES
    General notes
#>
function Remove-PhpIpamvrf{
    [cmdletBinding()]
    Param(
        [parameter(
            Mandatory=$true,
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true,
            Position=0,
            ParameterSetName="ByID"
        )]
        [int]$ID
        ,
        [parameter(
            Mandatory=$true,
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true,
            Position=0,
            ParameterSetName="ByName"
        )]
        [string]$Name,
        [parameter(ParameterSetName = "ByID",mandatory = $false)]
        [parameter(ParameterSetName = "ByName",mandatory = $false)]
        [hashtable]$PhpIpamSession=@{}
    )
    BEGIN{

    }
    PROCESS{
        if($PSCmdlet.ParameterSetName -eq 'ByID'){
            $r=Invoke-PhpIpamExecute -PhpIpamSession $PhpIpamSession -method delete -ContentType "application/json"  -controller vrf -identifiers $ID
            if($r -and $r.success){
                return $true
            }else{
                return $false
            }
        }
        if($PSCmdlet.ParameterSetName -eq 'ByName'){
            try{
                $vrfs=(Invoke-PhpIpamExecute -PhpIpamSession $PhpIpamSession -method get -controller vrf -identifiers @($name) -ErrorAction stop).data
                $vrfs|foreach-object{
                    Remove-PhpIpamvrf -PhpIpamSession $PhpIpamSession -ID $_.id
                }
            }catch{
                # do nothing ,because if vrf do not exist ,it will cause exception
                # vrf does not exist
            }
        }
    }
    END{

    }
}

Export-ModuleMember -Function Remove-PhpIpamvrf
