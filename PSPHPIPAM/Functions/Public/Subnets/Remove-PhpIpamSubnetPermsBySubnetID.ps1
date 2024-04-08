function Remove-PhpIpamSubnetPermsBySubnetID{
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
        $r=Invoke-PhpIpamExecute -method delete -controller subnets -identifiers @($ID,"permissions") -PhpIpamSession $PhpIpamSession
        if($r -and $r.success){
            return $true
        }else{
            return $false
        }
    }

    end{

    }
}

# TODO: how to set/add permission?

# new-alias Remove-PhpIpamSubnetAllPermissionsBySubnetID -value Remove-PhpIpamSubnetPermsBySubnetID
# Export-ModuleMember -Function Remove-PhpIpamSubnetPermsBySubnetID -alias Remove-PhpIpamSubnetAllPermissionsBySubnetID
