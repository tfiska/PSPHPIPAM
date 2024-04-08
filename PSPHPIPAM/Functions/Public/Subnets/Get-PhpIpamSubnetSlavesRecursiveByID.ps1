function Get-PhpIpamSubnetSlavesRecursiveByID{
    [cmdletBinding()]
    Param(
         [parameter(Mandatory=$true,ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true,position=0)]
         [int]$ID,
         [parameter(mandatory = $false)]
         [hashtable]$PhpIpamSession=@{}
    )

    begin{
        Write-Verbose $ID
    }
    process{
        $r=Invoke-PhpIpamExecute -method get -controller subnets -identifiers @($ID,"slaves_recursive") -PhpIpamSession $PhpIpamSession
        Resolve-PhpIpamExecuteResult -result $r
    }

    end{

    }
}

New-Alias -Name Get-PhpIpamSubnetSlaves_RecursiveByID -Value Get-PhpIpamSubnetSlavesRecursiveByID

Export-ModuleMember -Function Get-PhpIpamSubnetSlavesRecursiveByID -Alias Get-PhpIpamSubnetSlaves_RecursiveByID
