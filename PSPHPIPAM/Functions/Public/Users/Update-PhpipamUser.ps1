function Update-PhpIpamUser{
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
        $r=Invoke-PhpIpamExecute -method patch -controller tools -identifiers @("Users",$id) -params $Params -PhpIpamSession $PhpIpamSession -ErrorAction stop
        if($r -and $r.success){
            Get-PhpIpamUser -ID $r['id'] -PhpIpamSession $PhpIpamSession
        }
    }
    END{
        Return $r

        
    #$r=Invoke-PhpIpamExecute -method get -controller tools -identifiers Users -PhpIpamSession $PhpIpamSession
    #Resolve-PhpIpamExecuteResult -result $r
    }
}

 

Export-ModuleMember -Function Update-PhpIpamUser
    
