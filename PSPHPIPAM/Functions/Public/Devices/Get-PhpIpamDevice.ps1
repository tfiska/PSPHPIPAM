<#
.SYNOPSIS
    Get PhpIpam device by device name or device id
.DESCRIPTION
    Get PhpIpam device by device name or device id
.EXAMPLE
    PS C:\> New-PhpIpamdevice -Param @{"name"="device2"}

    id               : 8
    name             : device2
    description      :
    masterdevice    : 0
    permissions      :
    strictMode       : 1
    subnetOrdering   :
    order            :
    editDate         :
    showVLAN         : 0
    showVRF          : 0
    showSupernetOnly : 0
    DNS              :

    # get device by device name
    PS C:\> get-PhpIpamdevice device2

    # get device by device id
    PS C:\> get-PhpIpamdevice 8

    # specify -id to using explicitly ById ParameterSet
    PS C:\> get-PhpIpamdevice -id 8

    # specify -name to using explicitly ByName ParameterSet
    PS C:\> get-PhpIpamdevice -name device2

    # Create an device and get device info using pipeline
    PS C:\> New-PhpIpamdevice -Param @{"name"="device3"}|get-PhpIpamdevice

    id               : 10
    name             : device3
    description      :
    masterdevice    : 0
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
function Get-PhpIpamdevice {
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
            $r=Invoke-PhpIpamExecute -method get -controller devices -identifiers @($name) -PhpIpamSession $PhpIpamSession
        }
        if ($PSCmdlet.ParameterSetName -eq 'ByID') {
            $r=Invoke-PhpIpamExecute -method get -controller devices -identifiers @($ID) -PhpIpamSession $PhpIpamSession
        }
        Resolve-PhpIpamExecuteResult -result $r
    }

    end {

    }
}

New-Alias -Name Get-PhpIpamdeviceByName -Value Get-PhpIpamdevice
new-alias -Name Get-PhpIpamdeviceByID -Value Get-PhpIpamdevice
Export-ModuleMember  -function  Get-PhpIpamdevice -alias "Get-PhpIpamdeviceByName", "Get-PhpIpamdeviceByID"
