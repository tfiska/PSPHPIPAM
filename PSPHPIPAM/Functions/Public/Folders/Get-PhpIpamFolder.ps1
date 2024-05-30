<#
.SYNOPSIS
    Get PhpIpam folder by folder name or folder id
.DESCRIPTION
    Get PhpIpam folder by folder name or folder id
.EXAMPLE
    PS C:\> New-PhpIpamfolder -Param @{"name"="folder2"}

    id               : 8
    name             : folder2
    description      :
    masterfolder    : 0
    permissions      :
    strictMode       : 1
    subnetOrdering   :
    order            :
    editDate         :
    showVLAN         : 0
    showVRF          : 0
    showSupernetOnly : 0
    DNS              :

    # get folder by folder name
    PS C:\> get-PhpIpamfolder folder2

    # get folder by folder id
    PS C:\> get-PhpIpamfolder 8

    # specify -id to using explicitly ById ParameterSet
    PS C:\> get-PhpIpamfolder -id 8

    # specify -name to using explicitly ByName ParameterSet
    PS C:\> get-PhpIpamfolder -name folder2

    # Create an folder and get folder info using pipeline
    PS C:\> New-PhpIpamfolder -Param @{"name"="folder3"}|get-PhpIpamfolder

    id               : 10
    name             : folder3
    description      :
    masterfolder    : 0
    permissions      :
    strictMode       : 1
    subnetOrdering   :
    order            :
    editDate         :
    showVLAN         : 0
    showVRF          : 0
    showSupernetOnly : 0
    DNS              :

.INPUTS
    Inputs (if any)
.OUTPUTS
    Output (if any)
.NOTES
    General notes
#>
function Get-PhpIpamfolder {
    [cmdletbinding()]
    Param(
        [parameter(
            Mandatory = $true,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            position = 0,
            ParameterSetName = "ByName"
        )]
        [ValidateNotNullOrEmpty()]
        [string]$Name,

        [parameter(
            Mandatory = $true,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            position = 0,
            ParameterSetName = "ByID"
        )]
        [ValidateNotNullOrEmpty()]
        [int]$ID,
        [parameter(ParameterSetName = "ByID",mandatory = $false)]
        [parameter(ParameterSetName = "ByName",mandatory = $false)]
        [hashtable]$PhpIpamSession=@{}
    
    )

    begin {

    }
    process {
        if ($PSCmdlet.ParameterSetName -eq 'ByName') {
            $r=Invoke-PhpIpamExecute -method get -controller folders -identifiers @($name) -PhpIpamSession $PhpIpamSession
        }
        if ($PSCmdlet.ParameterSetName -eq 'ByID') {
            $r=Invoke-PhpIpamExecute -method get -controller folders -identifiers @($ID) -PhpIpamSession $PhpIpamSession
        }
        Resolve-PhpIpamExecuteResult -result $r
    }

    end {

    }
}

New-Alias -Name Get-PhpIpamfolderByName -Value Get-PhpIpamfolder
new-alias -Name Get-PhpIpamfolderByID -Value Get-PhpIpamfolder
Export-ModuleMember  -function  Get-PhpIpamfolder -alias "Get-PhpIpamfolderByName", "Get-PhpIpamfolderByID"
