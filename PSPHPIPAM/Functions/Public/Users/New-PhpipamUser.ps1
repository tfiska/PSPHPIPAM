function new-PhpIpamUser{
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
        $r=Invoke-PhpIpamExecute -method post -controller tools -identifiers "Users" -params $Params -PhpIpamSession $PhpIpamSession -ErrorAction stop
        if($r -and $r.success){
            $return=Get-PhpIpamUser -ID $r['id'] -PhpIpamSession $PhpIpamSession
        }
    }
    END{
        Return $return

        
    #$r=Invoke-PhpIpamExecute -method get -controller tools -identifiers Users -PhpIpamSession $PhpIpamSession
    #Resolve-PhpIpamExecuteResult -result $r
    }
}

 

Export-ModuleMember -Function new-PhpIpamUser
    
