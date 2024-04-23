function Get-PhpIpamLocation{
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
    $r=Invoke-PhpIpamExecute -method get -controller tools -identifiers @("locations",$ID) -PhpIpamSession $PhpIpamSession
    Resolve-PhpIpamExecuteResult -result $r
}

new-alias -Name Get-PhpIpamLocationByID -Value Get-PhpIpamLocation
Export-ModuleMember  -function  Get-PhpIpamLocation -alias "Get-PhpIpamLocationByID"
    
