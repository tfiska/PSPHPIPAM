<#
.SYNOPSIS
    Remove PhpIpam vlan
.DESCRIPTION
    Remove PhpIpam vlan
.EXAMPLE
    PS C:\> Remove-PhpIpamvlan -ID 20
    PS C:\> Remove-PhpIpamvlan -Name vlan1
    PS C:\> New-PhpIpamvlan -Param @{"name"="vlan5"}|Remove-PhpIpamvlan

.INPUTS
    Inputs (if any)
.OUTPUTS
    Output (if any)
.NOTES
    General notes
#>
function Remove-PhpIpamvlan{
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
            $r=Invoke-PhpIpamExecute -method delete -controller vlans -params @{'id'=$id}  -PhpIpamSession $PhpIpamSession
            if($r -and $r.success){
                return $true
            }else{
                return $false
            }
        }
        if($PSCmdlet.ParameterSetName -eq 'ByName'){
            try{
                $vlans=(Invoke-PhpIpamExecute -method get -controller vlans -identifiers @($name) -PhpIpamSession $PhpIpamSession -ErrorAction stop).data
                $vlans|foreach-object{
                    Remove-PhpIpamvlan -ID $_.id
                }
            }catch{
                # do nothing ,because if vlan do not exist ,it will cause exception
                # vlan does not exist
            }
        }
    }
    END{

    }
}

Export-ModuleMember -Function Remove-PhpIpamvlan
