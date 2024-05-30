function new-PhpIpamdevice_type{
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
        $r=Invoke-PhpIpamExecute -method post -controller tools -identifiers "device_types" -params $Params -PhpIpamSession $PhpIpamSession -ErrorAction stop
        
        if($r -and $r.success){
            if ($r -is [psCustomObject]) {
                $ID=$r.id
            }else {
                $ID=$r['id']
            }
            $return=Get-PhpIpamdevice_type -ID $ID -PhpIpamSession $PhpIpamSession
        }
    }
    END{
        Return $return

        
    #$r=Invoke-PhpIpamExecute -method get -controller tools -identifiers device_types -PhpIpamSession $PhpIpamSession
    #Resolve-PhpIpamExecuteResult -result $r
    }
}

 

Export-ModuleMember -Function new-PhpIpamdevice_type
    
