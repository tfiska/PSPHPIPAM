<#
.SYNOPSIS
    Remove PhpIpam device
.DESCRIPTION
    Remove PhpIpam device
.EXAMPLE
    PS C:\> Remove-PhpIpamdevice -ID 20
    PS C:\> Remove-PhpIpamdevice -Name device1
    PS C:\> New-PhpIpamdevice -Param @{"name"="device5"}|Remove-PhpIpamdevice

.INPUTS
    Inputs (if any)
.OUTPUTS
    Output (if any)
.NOTES
    General notes
#>
function Remove-PhpIpamdevice{
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
            $r=Invoke-PhpIpamExecute -method delete -ContentType "application/json" -controller devices -params @{'id'=$id}  -PhpIpamSession $PhpIpamSession
            if($r -and $r.success){
                return $true
            }else{
                return $false
            }
        }
        if($PSCmdlet.ParameterSetName -eq 'ByName'){
            try{
                $devices=(Invoke-PhpIpamExecute -method get -controller devices -identifiers @($name) -PhpIpamSession $PhpIpamSession -ErrorAction stop).data
                $devices|foreach-object{
                    Remove-PhpIpamdevice -ID $_.id
                }
            }catch{
                # do nothing ,because if device do not exist ,it will cause exception
                # device does not exist
            }
        }
    }
    END{

    }
}

Export-ModuleMember -Function Remove-PhpIpamdevice
