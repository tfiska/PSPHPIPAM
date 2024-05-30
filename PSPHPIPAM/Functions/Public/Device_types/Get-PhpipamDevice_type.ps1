function Get-PhpIpamdevice_type{
    [cmdletbinding()]
    param(
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
        
        [hashtable]$PhpIpamSession=@{}
    
    )
    $r=Invoke-PhpIpamExecute -method get -controller tools -identifiers @("device_types",$ID) -PhpIpamSession $PhpIpamSession
    Resolve-PhpIpamExecuteResult -result $r
}

new-alias -Name Get-PhpIpamdevice_typeByID -Value Get-PhpIpamdevice_type
Export-ModuleMember  -function  Get-PhpIpamdevice_type -alias "Get-PhpIpamdevice_typeByID"
    
