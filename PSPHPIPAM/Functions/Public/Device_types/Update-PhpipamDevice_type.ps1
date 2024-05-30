function Update-PhpIpamdevice_type{
    [cmdletbinding()]
    param(
        [parameter(Mandatory=$true,ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true,Position=0)]
        [validatescript({$_ -is [hashtable] -or $_ -is [psCustomObject]})]
        $Params,

        [parameter(mandatory = $false)]
        [hashtable]$PhpIpamSession=@{}
    )
    BEGIN{
        $id=$Params.id
        if ($Params -is [hashtable]){$Params.remove("id")}
        else {$Params.PSObject.Properties.remove("id")}

    }
    PROCESS{
        $r=Invoke-PhpIpamExecute -method patch -ContentType "application/json" -controller tools -identifiers @("device_types",$id) -params $Params -PhpIpamSession $PhpIpamSession -ErrorAction stop 
        if($r -and $r.success){
            $r=Get-PhpIpamdevice_type -ID $id -PhpIpamSession $PhpIpamSession 
        }
    }
    END{
        Return $r

        
    #$r=Invoke-PhpIpamExecute -method get -controller tools -identifiers device_types -PhpIpamSession $PhpIpamSession
    #Resolve-PhpIpamExecuteResult -result $r
    }
}

 

Export-ModuleMember -Function Update-PhpIpamdevice_type
    
