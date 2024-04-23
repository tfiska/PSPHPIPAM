function new-PhpIpamLocation{
    [cmdletbinding()]
    param(
        [parameter(Mandatory=$true,ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true,Position=0)]
        [validatescript({$_ -is [hashtable] -or $_ -is [psCustomObject]})]
        $Params,

        [parameter(mandatory = $false)]
        [hashtable]$PhpIpamSession=@{}
    )
    BEGIN{

    }
    PROCESS{
        $r=Invoke-PhpIpamExecute -method post -controller tools -identifiers "locations" -params $Params -PhpIpamSession $PhpIpamSession -ErrorAction stop
        
        if($r -and $r.success){
            if ($r -is [psCustomObject]) {
                $ID=$r.id
            }else {
                $ID=$r['id']
            }
            $return=Get-PhpIpamLocation -ID $ID -PhpIpamSession $PhpIpamSession
        }
    }
    END{
        Return $return

        
    #$r=Invoke-PhpIpamExecute -method get -controller tools -identifiers locations -PhpIpamSession $PhpIpamSession
    #Resolve-PhpIpamExecuteResult -result $r
    }
}

 

Export-ModuleMember -Function new-PhpIpamLocation
    
