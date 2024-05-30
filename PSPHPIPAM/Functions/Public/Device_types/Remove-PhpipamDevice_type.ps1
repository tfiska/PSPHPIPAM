<#
.SYNOPSIS
    Remove PhpIpam Section
.DESCRIPTION
    Remove PhpIpam Section
.EXAMPLE
    PS C:\> Remove-PhpIpamdevice_type -ID 20
    PS C:\> Remove-PhpIpamdevice_type -Name Section1
    PS C:\> New-PhpIpamdevice_type -Param @{"name"="section5"}|Remove-PhpIpamdevice_type

.INPUTS
    Inputs (if any)
.OUTPUTS
    Output (if any)
.NOTES
    General notes
#>
function Remove-PhpIpamdevice_type{
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
            $r=Invoke-PhpIpamExecute -method delete -controller tools -params @("device_types",$ID)  -PhpIpamSession $PhpIpamSession
            if($r -and $r.success){
                return $true
            }else{
                return $false
            }
        }
        # if($PSCmdlet.ParameterSetName -eq 'ByName'){
        #     try{
        #         $device_type=(Invoke-PhpIpamExecute -method get -controller tools -identifiers @("device_types",$name) -PhpIpamSession $PhpIpamSession -ErrorAction stop).data
        #         $device_type|foreach-object{
        #             Remove-PhpIpamdevice_type -ID $_.id
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
#New-Alias -Name Remove-PhpIpamdevice_typeByName -Value Remove-PhpIpamdevice_type
new-alias -Name Remove-PhpIpamdevice_typeByID -Value Remove-PhpIpamdevice_type
Export-ModuleMember  -function  Remove-PhpIpamdevice_type -alias "Remove-PhpIpamdevice_typeByID"
