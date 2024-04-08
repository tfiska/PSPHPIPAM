<#
.SYNOPSIS
    Remove PhpIpam Section
.DESCRIPTION
    Remove PhpIpam Section
.EXAMPLE
    PS C:\> Remove-PhpIpamSection -ID 20
    PS C:\> Remove-PhpIpamSection -Name Section1
    PS C:\> New-PhpIpamSection -Param @{"name"="section5"}|Remove-PhpIpamSection

.INPUTS
    Inputs (if any)
.OUTPUTS
    Output (if any)
.NOTES
    General notes
#>
function Remove-PhpIpamSection{
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
            $r=Invoke-PhpIpamExecute -method delete -controller sections -params @{'id'=$id}  -PhpIpamSession $PhpIpamSession
            if($r -and $r.success){
                return $true
            }else{
                return $false
            }
        }
        if($PSCmdlet.ParameterSetName -eq 'ByName'){
            try{
                $sections=(Invoke-PhpIpamExecute -method get -controller sections -identifiers @($name) -PhpIpamSession $PhpIpamSession -ErrorAction stop).data
                $sections|foreach-object{
                    Remove-PhpIpamSection -ID $_.id
                }
            }catch{
                # do nothing ,because if section do not exist ,it will cause exception
                # Section does not exist
            }
        }
    }
    END{

    }
}

Export-ModuleMember -Function Remove-PhpIpamSection
