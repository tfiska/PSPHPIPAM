<#
.SYNOPSIS
    Remove PhpIpam Section
.DESCRIPTION
    Remove PhpIpam Section
.EXAMPLE
    PS C:\> Remove-PhpIpamLocation -ID 20
    PS C:\> Remove-PhpIpamLocation -Name Section1
    PS C:\> New-PhpIpamLocation -Param @{"name"="section5"}|Remove-PhpIpamLocation

.INPUTS
    Inputs (if any)
.OUTPUTS
    Output (if any)
.NOTES
    General notes
#>
function Remove-PhpIpamLocation{
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
            $r=Invoke-PhpIpamExecute -method delete -controller tools -params @("locations",$ID)  -PhpIpamSession $PhpIpamSession
            if($r -and $r.success){
                return $true
            }else{
                return $false
            }
        }
        # if($PSCmdlet.ParameterSetName -eq 'ByName'){
        #     try{
        #         $Location=(Invoke-PhpIpamExecute -method get -controller tools -identifiers @("locations",$name) -PhpIpamSession $PhpIpamSession -ErrorAction stop).data
        #         $Location|foreach-object{
        #             Remove-PhpIpamLocation -ID $_.id
        #         }
        #     }catch{
        #         # do nothing ,because if section do not exist ,it will cause exception
        #         # Section does not exist
        #     }
        # }
    }
    END{

    }
}
#New-Alias -Name Remove-PhpIpamLocationByName -Value Remove-PhpIpamLocation
new-alias -Name Remove-PhpIpamLocationByID -Value Remove-PhpIpamLocation
Export-ModuleMember  -function  Remove-PhpIpamLocation -alias "Remove-PhpIpamLocationByID"
