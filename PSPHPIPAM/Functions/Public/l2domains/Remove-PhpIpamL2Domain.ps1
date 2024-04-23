<#
.SYNOPSIS
    Remove PhpIpam l2domain
.DESCRIPTION
    Remove PhpIpam l2domain
.EXAMPLE
    PS C:\> Remove-PhpIpaml2domain -ID 20
    PS C:\> Remove-PhpIpaml2domain -Name l2domain1
    PS C:\> New-PhpIpaml2domain -Param @{"name"="l2domain5"}|Remove-PhpIpaml2domain

.INPUTS
    Inputs (if any)
.OUTPUTS
    Output (if any)
.NOTES
    General notes
#>
function Remove-PhpIpaml2domain{
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
            $r=Invoke-PhpIpamExecute -method delete -controller l2domains -params @{'id'=$id}  -PhpIpamSession $PhpIpamSession
            if($r -and $r.success){
                return $true
            }else{
                return $false
            }
        }
        if($PSCmdlet.ParameterSetName -eq 'ByName'){
            try{
                $l2domains=(Invoke-PhpIpamExecute -method get -controller l2domains -identifiers @($name) -PhpIpamSession $PhpIpamSession -ErrorAction stop).data
                $l2domains|foreach-object{
                    Remove-PhpIpaml2domain -ID $_.id
                }
            }catch{
                # do nothing ,because if l2domain do not exist ,it will cause exception
                # l2domain does not exist
            }
        }
    }
    END{

    }
}

Export-ModuleMember -Function Remove-PhpIpaml2domain
