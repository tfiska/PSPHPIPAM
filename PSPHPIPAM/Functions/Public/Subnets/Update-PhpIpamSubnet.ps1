<#
.SYNOPSIS
    Update Subnet
.DESCRIPTION
    Update Subnet
.PARAMETER Params
    Subnet info which can be hashtable or pscustomobject

.EXAMPLE
    PS C:\> New-PhpIpamSubnet -Params @{sectionId=1;subnet='192.168.10.0';mask=24}
    PS C:\> $UpdatedSubnet=@{id=$subnet.id;description="this was a test"}
    PS C:\> Update-PhpIpamSubnet -Params $UpdatedSubnet

.INPUTS
    Inputs (if any)
.OUTPUTS
    Output (if any)
.NOTES
    General notes
#>
function Update-PhpIpamSubnet{
    [cmdletBinding()]
    param(
        [parameter(mandatory = $true,ParameterSetName="Singelparam")]
        [string]$FieldName,
        [parameter(mandatory = $true,ParameterSetName="Singelparam")]
        [Int32]$ID,
        [parameter(mandatory = $true,ParameterSetName="Singelparam")]
        $FieldValue,
        [parameter(Mandatory=$true,ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true,Position=0,ParameterSetName="Multiparam")]
        [validatescript({$_ -is [hashtable] -or $_ -is [psCustomObject]})]
        $Params=@{}, 
        [parameter(mandatory = $false,ParameterSetName="Multiparam")]
        [parameter(mandatory = $false,ParameterSetName="Singelparam")]
        [hashtable]$PhpIpamSession=@{}
    )
    BEGIN{
        $removefields=@("editDate")
        $identifiers=@("subnets")
        if($PSCmdlet.ParameterSetName -eq 'Multiparam'){
            $changeObject=$Params  | ConvertTo-Json | ConvertFrom-Json
            $changeObject.psobject.Properties.name | ForEach-Object {
                if (-not $changeObject.$_){$changeObject.PSObject.Properties.remove($_)
                }elseif ($_ -in $removefields){$changeObject.PSObject.Properties.remove($_)
                }elseif ($changeObject.$_[0] -is [psCustomObject]) {
                    $changeObject.$_='{' + $($(foreach ($obj in $changeObject.$_){($obj.psobject.properties| Where-Object {$_.value -match "^[\d\.]+$"} | ForEach-Object {$_.Value}) -join ":" } ) -join "," ) + '}'
                }
                
            }
            $ID=$changeObject.id
            $identifiers=[Int64]$ID
            if ($changeObject -is [hashtable]){
                $changeObject.remove("id")
            }
            else {
                $changeObject.PSObject.Properties.remove("id")
            }
            if ($changeObject.location -and $changeObject.location.id){$changeObject.location=$changeObject.location.id}
        }
        elseif($PSCmdlet.ParameterSetName -eq 'Singelparam'){
            $identifiers+=$ID
            $identifiers+="?$FieldName=$FieldValue"
            #$Query="?$FieldName=$FieldValue"
            #$Params=@{id=$ID;$FieldName=$FieldValue}

        }

    }
    PROCESS{
        if($PSCmdlet.ParameterSetName -eq 'Multiparam'){
            $r=Invoke-PhpIpamExecute -method patch -ContentType "application/json" -controller subnets -identifiers $ID -params $changeObject -PhpIpamSession $PhpIpamSession
         
        }elseif($PSCmdlet.ParameterSetName -eq 'Singelparam'){
            $hash=@{
                Method="PATCH"
                Headers=@{token=$($PhpIpamSession.PhpIpamToken)}
                uri="$($PhpIpamSession.PhpIpamApiUrl)/$($PhpIpamSession.PhpIpamAppID)/$($identifiers -join "/")"
                ContentType="application/json"
                #body=$Params
            }
            if ($PSVersionTable.PSVersion.Major -ge 7) {$hash.Add("SkipCertificateCheck",$true)}
            $r=Invoke-RestMethod @hash
            #$r=Invoke-PhpIpamExecute -method patch -ContentType "application/json" -controller subnets -identifiers $identifiers -PhpIpamSession $PhpIpamSession
        }
        if($r -and $r.success){
            $r=Get-PhpIpamSubnet -PhpIpamSession $PhpIpamSession -id $ID
        }else{
            Write-Error $r
        }
    }
    END{
        Return $r
    }
}

Export-ModuleMember -Function Update-PhpIpamSubnet
