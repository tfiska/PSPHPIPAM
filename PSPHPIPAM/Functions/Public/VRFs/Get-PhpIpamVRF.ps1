<#
.SYNOPSIS
    Get PhpIpam vrf by vrf name or vrf id
.DESCRIPTION
    Get PhpIpam vrf by vrf name or vrf id
.EXAMPLE
    PS C:\> New-PhpIpamvrf -Param @{"name"="vrf2"}

    id               : 8
    name             : vrf2
    description      :
    mastervrf    : 0
    permissions      :
    strictMode       : 1
    subnetOrdering   :
    order            :
    editDate         :
    showVLAN         : 0
    showVRF          : 0
    showSupernetOnly : 0
    DNS              :

    # get vrf by vrf name
    PS C:\> get-PhpIpamvrf vrf2

    # get vrf by vrf id
    PS C:\> get-PhpIpamvrf 8

    # specify -id to using explicitly ById ParameterSet
    PS C:\> get-PhpIpamvrf -id 8

    # specify -name to using explicitly ByName ParameterSet
    PS C:\> get-PhpIpamvrf -name vrf2

    # Create an vrf and get vrf info using pipeline
    PS C:\> New-PhpIpamvrf -Param @{"name"="vrf3"}|get-PhpIpamvrf

    id               : 10
    name             : vrf3
    description      :
    mastervrf    : 0
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
function Get-PhpIpamvrf {
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
            $r=Invoke-PhpIpamExecute -method get -controller vrf -identifiers @($name) -PhpIpamSession $PhpIpamSession
        }
        if ($PSCmdlet.ParameterSetName -eq 'ByID') {
            $r=Invoke-PhpIpamExecute -method get -controller vrf -identifiers @($ID) -PhpIpamSession $PhpIpamSession
        }
        Resolve-PhpIpamExecuteResult -result $r
    }

    end {

    }
}

New-Alias -Name Get-PhpIpamvrfByName -Value Get-PhpIpamvrf
new-alias -Name Get-PhpIpamvrfByID -Value Get-PhpIpamvrf
Export-ModuleMember  -function  Get-PhpIpamvrf -alias "Get-PhpIpamvrfByName", "Get-PhpIpamvrfByID"
