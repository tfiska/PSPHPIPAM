<#
.SYNOPSIS
    Create PhpIpamCustomer
.DESCRIPTION
    Create PhpIpamCustomer
.EXAMPLE
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
function New-PhpIpamCustomer{

    [cmdletBinding()]
    Param(
        [parameter(Mandatory=$true,ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true,Position=0)]
        [validateScript({$_ -is [system.collections.hashtable]})]
        $Params=@{}
    )
    begin{

    }
    process{

        if($(
            Invoke-PhpIpamExecute -method post -controller tools -identifiers customers -params $Params
            ).success){
            if($Params.ContainsKey('name')){
                Get-PhpIpamCustomerByName -Name $Params['name']
            }
        }
    }
    end{

    }
}

Export-ModuleMember -Function New-PhpIpamCustomer
