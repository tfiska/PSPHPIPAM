<#
.SYNOPSIS
    Get PhpIpam vlan by vlan name or vlan id
.DESCRIPTION
    Get PhpIpam vlan by vlan name or vlan id
.EXAMPLE
    PS C:\> New-PhpIpamvlan -Param @{"name"="vlan2"}

    id               : 8
    name             : vlan2
    description      :
    mastervlan    : 0
    permissions      :
    strictMode       : 1
    subnetOrdering   :
    order            :
    editDate         :
    showVLAN         : 0
    showVRF          : 0
    showSupernetOnly : 0
    DNS              :

    # get vlan by vlan name
    PS C:\> get-PhpIpamvlan vlan2

    # get vlan by vlan id
    PS C:\> get-PhpIpamvlan 8

    # specify -id to using explicitly ById ParameterSet
    PS C:\> get-PhpIpamvlan -id 8

    # specify -name to using explicitly ByName ParameterSet
    PS C:\> get-PhpIpamvlan -name vlan2

    # Create an vlan and get vlan info using pipeline
    PS C:\> New-PhpIpamvlan -Param @{"name"="vlan3"}|get-PhpIpamvlan

    id               : 10
    name             : vlan3
    description      :
    mastervlan    : 0
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
function Get-PhpIpamvlan {
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
            $r=Invoke-PhpIpamExecute -method get -controller vlans -identifiers @($name) -PhpIpamSession $PhpIpamSession
        }
        if ($PSCmdlet.ParameterSetName -eq 'ByID') {
            $r=Invoke-PhpIpamExecute -method get -controller vlans -identifiers @($ID) -PhpIpamSession $PhpIpamSession
        }
        Resolve-PhpIpamExecuteResult -result $r
    }

    end {

    }
}

New-Alias -Name Get-PhpIpamvlanByName -Value Get-PhpIpamvlan
new-alias -Name Get-PhpIpamvlanByID -Value Get-PhpIpamvlan
Export-ModuleMember  -function  Get-PhpIpamvlan -alias "Get-PhpIpamvlanByName", "Get-PhpIpamvlanByID"
