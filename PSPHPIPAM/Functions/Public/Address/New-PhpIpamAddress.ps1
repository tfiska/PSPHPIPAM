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
        [parameter(Mandatory=$true,ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true,Position=0)]$params,
        [parameter(mandatory = $false)]
        [hashtable]$PhpIpamSession=@{},
        [parameter(mandatory = $false)][string]$ContentType="application/json;charset=UTF-8"
    )

    begin{

    }
    process{
          Write-Verbose "Params = $($($params | ConvertTo-Json )  -replace '(^\s+|\s+$)','' -replace '\s+',' ')" 
          $r=Invoke-PhpIpamExecute -ContentType "$ContentType" -PhpIpamSession $PhpIpamSession -method post -controller addresses  -params $params
          Write-Verbose "Result = $($($r | ConvertTo-Json )  -replace '(^\s+|\s+$)','' -replace '\s+',' ')" 
          if($r -and $r.success){
              return  Get-PhpIpamAddress -PhpIpamSession $PhpIpamSession -ID $r.id
          }elseif ($r){
              Write-warning "Response : $($($r | ConvertTo-Json )  -replace '(^\s+|\s+$)','' -replace '\s+',' ') Params = $($($params | ConvertTo-Json )  -replace '(^\s+|\s+$)','' -replace '\s+',' ')"
          } else {
              write-warning "Empty response: Params = $($($params | ConvertTo-Json )  -replace '(^\s+|\s+$)','' -replace '\s+',' ')"
          }
    }

    end{

    }
}

Export-ModuleMember -Function New-PhpIpamAddress
