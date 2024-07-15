<#
.SYNOPSIS
    Get All custom_fields of controller
.DESCRIPTION
    Get All custom_fields of controller
.EXAMPLE
    PS C:\>Get-PhpIpamCustomFields

.INPUTS
    No Inputs Need
.OUTPUTS
    Output (if any)
.NOTES

#>
function Get-PhpIpamCustomFields{
    [OutputType([System.Collections.ArrayList])]
    [cmdletbinding()]
    param(
        [Parameter(Mandatory=$true)]
        [ValidateSet("sections","subnets","folders","addresses","vlans","vlan","l2domains","vrf","tools","prefix","user","devices")]
        [string[]]
        $Controllers,

        [parameter(mandatory = $false)]
        [hashtable]$PhpIpamSession=@{}
    )
    
    $Output = New-Object System.Collections.ArrayList
    Write-Verbose "$($Controllers)"
    ForEach ($Controller in $Controllers){

        $r=Invoke-PhpIpamExecute -method get -controller $Controller -identifiers @('custom_fields') -PhpIpamSession $PhpIpamSession
        if ($r.data){
            $r.data | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty Name | ForEach-Object {
                $r.data.$_ | Add-Member -MemberType NoteProperty -Name "Controller" -Value $Controller
                $Output.add($r.data.$_) | Out-Null
            }
        }
        #[System.Collections.ArrayList]$Output=Resolve-PhpIpamExecuteResult -result $r
    }
    Return ,$Output
}

New-Alias  -name 'Get-PhpIpamCustom_Fields' -Value Get-PhpIpamCustomFields
Export-ModuleMember -Function Get-PhpIpamCustomFields -Alias Get-PhpIpamCustom_Fields
