<#
.SYNOPSIS
    Get PhpIpam Section by section name or section id
.DESCRIPTION
    Get PhpIpam Section by section name or section id
.EXAMPLE
    PS C:\> New-PhpIpamCustomer -Param @{"name"="section2"}

    id               : 8
    name             : section2
    description      :
    masterSection    : 0
    permissions      :
    strictMode       : 1
    subnetOrdering   :
    order            :
    editDate         :
    showVLAN         : 0
    showVRF          : 0
    showSupernetOnly : 0
    DNS              :

    # get section by section name
    PS C:\> get-PhpIpamCustomer section2

    # get section by section id
    PS C:\> get-PhpIpamCustomer 8

    # specify -id to using explicitly ById ParameterSet
    PS C:\> get-PhpIpamCustomer -id 8

    # specify -name to using explicitly ByName ParameterSet
    PS C:\> get-PhpIpamCustomer -name section2

    # Create an section and get section info using pipeline
    PS C:\> New-PhpIpamCustomer -Param @{"name"="section3"}|get-PhpIpamCustomer

    id               : 10
    name             : section3
    description      :
    masterSection    : 0
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
function Get-PhpIpamCustomer {
    [cmdletbinding()]
    Param(
        [parameter(
            Mandatory = $true,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            position = 0
        )]
        [ValidateNotNullOrEmpty()]
        [int]$ID,
        [parameter(mandatory = $false)][hashtable]$PhpIpamSession=@{}
    )

    begin {

    }
    process {
        $r=Invoke-PhpIpamExecute -method get -controller tools -identifiers @("customers",$ID)  -PhpIpamSession $PhpIpamSession
        
        Resolve-PhpIpamExecuteResult -result $r
    }

    end {

    }
}


new-alias -Name Get-PhpIpamCustomerByID -Value Get-PhpIpamCustomer
Export-ModuleMember  -function  Get-PhpIpamCustomer -alias "Get-PhpIpamCustomerByID"
