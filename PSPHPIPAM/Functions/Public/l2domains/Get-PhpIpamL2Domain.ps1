<#
.SYNOPSIS
    Get PhpIpam l2domain by l2domain name or l2domain id
.DESCRIPTION
    Get PhpIpam l2domain by l2domain name or l2domain id
.EXAMPLE
    PS C:\> New-PhpIpaml2domain -Param @{"name"="l2domain2"}

    id               : 8
    name             : l2domain2
    description      :
    masterl2domain    : 0
    permissions      :
    strictMode       : 1
    subnetOrdering   :
    order            :
    editDate         :
    showVLAN         : 0
    showVRF          : 0
    showSupernetOnly : 0
    DNS              :

    # get l2domain by l2domain name
    PS C:\> get-PhpIpaml2domain l2domain2

    # get l2domain by l2domain id
    PS C:\> get-PhpIpaml2domain 8

    # specify -id to using explicitly ById ParameterSet
    PS C:\> get-PhpIpaml2domain -id 8

    # specify -name to using explicitly ByName ParameterSet
    PS C:\> get-PhpIpaml2domain -name l2domain2

    # Create an l2domain and get l2domain info using pipeline
    PS C:\> New-PhpIpaml2domain -Param @{"name"="l2domain3"}|get-PhpIpaml2domain

    id               : 10
    name             : l2domain3
    description      :
    masterl2domain    : 0
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
function Get-PhpIpaml2domain {
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
            $r=Invoke-PhpIpamExecute -method get -controller l2domains -identifiers @($name) -PhpIpamSession $PhpIpamSession
        }
        if ($PSCmdlet.ParameterSetName -eq 'ByID') {
            $r=Invoke-PhpIpamExecute -method get -controller l2domains -identifiers @($ID) -PhpIpamSession $PhpIpamSession
        }
        Resolve-PhpIpamExecuteResult -result $r
    }

    end {

    }
}

New-Alias -Name Get-PhpIpaml2domainByName -Value Get-PhpIpaml2domain
new-alias -Name Get-PhpIpaml2domainByID -Value Get-PhpIpaml2domain
Export-ModuleMember  -function  Get-PhpIpaml2domain -alias "Get-PhpIpaml2domainByName", "Get-PhpIpaml2domainByID"
