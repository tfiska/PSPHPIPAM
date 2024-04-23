<#
    .DESCRIPTION
    Clean saved PhpIpamSession variables which contains apiId and apiTokens

    .EXAMPLE
    Remove-phpipamSession
#>
function Remove-PhpIpamSession {
    [cmdletbinding()]
    param(

    )
    $local:VariableNames=@("PhpIpamUsername","PhpIpamPassword","PhpIpamApiUrl","PhpIpamAppID","PhpIpamAppKey","PhpIpamToken","PhpIpamTokenExpires","PhpIpamTokenAuth","PhpIpamStaticToken")
    $script:PhpIpamUsername = $null
    $script:PhpIpamPassword = $null
    $script:PhpIpamApiUrl = $null
    $script:PhpIpamAppID = $null
    $script:PhpIpamAppKey = $null
    $script:PhpIpamToken = $null
    $script:PhpIpamTokenExpires = $null
    $script:PhpIpamTokenAuth = $null
    $script:PhpIpamStaticToken = $null
    Get-Variable -Scope script | Where-Object {$_.Name -iin $local:VariableNames} | ForEach-Object {Remove-Variable -Scope script -Name $_.Name}

    return $true
}

Export-ModuleMember -Function Remove-phpipamSession
