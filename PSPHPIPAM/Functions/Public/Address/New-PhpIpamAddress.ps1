<#
.SYNOPSIS
  Create New Address in a subnet
.DESCRIPTION
  Create New Address in a subnet
.EXAMPLE

  PS C:\> New-PhpIpamAddress -params @{subnetId=10;ip='192.168.10.2'}
  PS C:\> Get-PhpIpamAddresses -id 11
  PS C:\> Get-PhpIpamAddressesByIP 192.168.10.2

.INPUTS
  Inputs (if any)
.OUTPUTS
  the Address Id
.NOTES
  General notes
#>
function New-PhpIpamAddress{
    [cmdletBinding()]
    Param(
     [parameter(Mandatory=$true,ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true,Position=0)]
      $params,

      [parameter(mandatory = $false)]
      [hashtable]$PhpIpamSession=@{}
    )

    begin{

    }
    process{
          $r=Invoke-PhpIpamExecute -PhpIpamSession $PhpIpamSession -method post -controller addresses -ContentType "application/json"  -params $params
          if($r -and $r.success){
          return  Get-PhpIpamAddress -PhpIpamSession $PhpIpamSession -ID $r.id
          }else{
            write-information "Params = $($($params | ConvertTo-Json )  -replace '(^\s+|\s+$)','' -replace '\s+',' ')" 
            if ($r){
              Write-Error $r
            }
          }
    }

    end{

    }
}

Export-ModuleMember -Function New-PhpIpamAddress
