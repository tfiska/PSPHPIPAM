function Update-PhpIpamLocation{
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
        $r=Invoke-PhpIpamExecute -method patch -ContentType "application/json" -controller tools -identifiers @("locations",$id) -params $Params -PhpIpamSession $PhpIpamSession -ErrorAction stop 
        if($r -and $r.success){
            $r=Get-PhpIpamLocation -ID $id -PhpIpamSession $PhpIpamSession 
        }
    }
    END{
        Return $r

        
    #$r=Invoke-PhpIpamExecute -method get -controller tools -identifiers locations -PhpIpamSession $PhpIpamSession
    #Resolve-PhpIpamExecuteResult -result $r
    }
}

 

Export-ModuleMember -Function Update-PhpIpamLocation
    
