function Search-Phpipam{
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
        write-error "Feature not working :("
        Return $false
        $searchstring="addresses=1"
        $hash=@{
            uri="$($PhpIpamSession.PhpIpamApiUrl)/userssl/$($PhpIpamSession.PhpIpamAppID)/search/$searchstring/?$searchstring"
            Method="get"
            Headers=@{token=$($PhpIpamSession.PhpIpamToken)}
        }
        #Invoke-WebRequest @hash -SkipCertificateCheck
        #Invoke-RestMethod -verbose -debug @hash -SkipCertificateCheck
    #$r=Invoke-PhpIpamExecute -method get -controller search -PhpIpamSession $PhpIpamSession -identifiers @("locations") 
    #Resolve-PhpIpamExecuteResult -result $r
}


#Export-ModuleMember  -function  Search-Phpipam
    
