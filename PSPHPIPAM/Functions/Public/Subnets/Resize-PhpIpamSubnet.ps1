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
    $ID=7076 
    $MASK=18
#>
function Resize-PhpIpamSubnet{
    [cmdletBinding()]
    param(
        [int]$MASK,
        [Int32]$ID,
        [hashtable]$PhpIpamSession=@{}
    )
    BEGIN{
        
            $identifiers=@("subnets","$ID","resize")
            #$Query="?$FieldName=$FieldValue"
            #$Params=@{id=$ID;$FieldName=$FieldValue}

        

    }
    PROCESS{
            $hash=@{
                Method="PATCH"
                Headers=@{token=$($PhpIpamSession.PhpIpamToken)}
                uri="$($PhpIpamSession.PhpIpamApiUrl)/$($PhpIpamSession.PhpIpamAppID)/$($identifiers -join "/")/"
                ContentType="application/json"
                body=$(@{"mask"="$MASK"}| ConvertTo-Json)
            }
            if ($PSVersionTable.PSVersion.Major -ge 7) {$hash.Add("SkipCertificateCheck",$true)}
            $r=Invoke-RestMethod @hash
            #$r=Invoke-PhpIpamExecute -method patch -ContentType "application/json" -controller subnets -identifiers $identifiers -PhpIpamSession $PhpIpamSession
        
        if($r -and $r.success){
            $r=Get-PhpIpamSubnet -PhpIpamSession $PhpIpamSession -id $ID
        }else{
            Write-Error $r
            $r=""
        }
    }
    END{
        Return $r
    }
}

Export-ModuleMember -Function Resize-PhpIpamSubnet
