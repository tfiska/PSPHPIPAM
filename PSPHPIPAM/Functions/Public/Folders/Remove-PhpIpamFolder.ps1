<#
.SYNOPSIS
    Remove PhpIpam folder
.DESCRIPTION
    Remove PhpIpam folder
.EXAMPLE
    PS C:\> Remove-PhpIpamfolder -ID 20
    PS C:\> Remove-PhpIpamfolder -Name folder1
    PS C:\> New-PhpIpamfolder -Param @{"name"="folder5"}|Remove-PhpIpamfolder

.INPUTS
    Inputs (if any)
.OUTPUTS
    Output (if any)
.NOTES
    General notes
#>
function Remove-PhpIpamfolder{
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
            $r=Invoke-PhpIpamExecute -method delete -controller folders -params @{'id'=$id}  -PhpIpamSession $PhpIpamSession
            if($r -and $r.success){
                return $true
            }else{
                return $false
            }
        }
        if($PSCmdlet.ParameterSetName -eq 'ByName'){
            try{
                $folders=(Invoke-PhpIpamExecute -method get -controller folders -identifiers @($name) -PhpIpamSession $PhpIpamSession -ErrorAction stop).data
                $folders|foreach-object{
                    Remove-PhpIpamfolder -ID $_.id
                }
            }catch{
                # do nothing ,because if folder do not exist ,it will cause exception
                # folder does not exist
            }
        }
    }
    END{

    }
}

Export-ModuleMember -Function Remove-PhpIpamfolder
