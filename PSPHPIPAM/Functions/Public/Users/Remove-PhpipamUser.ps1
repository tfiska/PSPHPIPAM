<#
.SYNOPSIS
    Remove PhpIpam Section
.DESCRIPTION
    Remove PhpIpam Section
.EXAMPLE
    PS C:\> Remove-PhpIpamUser -ID 20
    PS C:\> Remove-PhpIpamUser -Name Section1
    PS C:\> New-PhpIpamUser -Param @{"name"="section5"}|Remove-PhpIpamUser

.INPUTS
    Inputs (if any)
.OUTPUTS
    Output (if any)
.NOTES
    General notes
#>
function Remove-PhpIpamUser{
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
            $r=Invoke-PhpIpamExecute -method delete -controller tools -params @("Users",$ID)  -PhpIpamSession $PhpIpamSession
            if($r -and $r.success){
                return $true
            }else{
                return $false
            }
        }
        # if($PSCmdlet.ParameterSetName -eq 'ByName'){
        #     try{
        #         $User=(Invoke-PhpIpamExecute -method get -controller tools -identifiers @("Users",$name) -PhpIpamSession $PhpIpamSession -ErrorAction stop).data
        #         $User|foreach-object{
        #             Remove-PhpIpamUser -ID $_.id
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
#New-Alias -Name Remove-PhpIpamUserByName -Value Remove-PhpIpamUser
new-alias -Name Remove-PhpIpamUserByID -Value Remove-PhpIpamUser
Export-ModuleMember  -function  Remove-PhpIpamUser -alias "Remove-PhpIpamUserByID"
