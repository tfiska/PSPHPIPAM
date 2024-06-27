function Resolve-PhpIpamExecuteResult {
    [cmdletbinding()]
    param (
        $result
    )
    Write-Debug "Input Result=$($result|convertto-json -Depth 100)"

    if($result -and $result.success -and $result.data){
        return $result.data
    }else{
    # }elseif($result -and $result.success){
    #     $result2=New-Object System.Collections.ArrayList
    #     Return , $result2
    # }elseif($result){
    #     Write-Error $result
    #     Return , $result2
        
        #Write-Error $r       return , $result.data
    }
}
