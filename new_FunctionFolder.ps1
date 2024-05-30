
#In Foldername to copy from - related to script location ie "PSPHPIPAM\Functions\Public\Users"
$IN="PSPHPIPAM\Functions\Public\Locations"
#Object name (without the plural ending "s")
$NewObjectName="Device_type"

$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
$INFolder="$scriptPath\$IN"
$InFolderObject=Get-Item $INFolder
$OldObjectName=([string]"$($InFolderObject.BaseName)").Substring(0,([string]"$($InFolderObject.BaseName)").Length-1)

Copy-Item -Path $INFolder -Destination "$($InFolderObject.parent.FullName)\$($NewObjectName)s" -Recurse -Container

$Files=Get-Item "$("$($InFolderObject.parent.FullName)\$($NewObjectName)s")\*"
foreach ($File in $Files) {
    $Newname=$($File.Basename) -replace $OldObjectName,$NewObjectName
    (Get-Content $file) -replace $OldObjectName,$NewObjectName.ToLower() | Set-Content $File
    Rename-Item -Path $File.FullName -NewName "$($File.Directory.FullName)\$($newname)$($File.Extension)"
}
#Rename-Item -Path "c:\logfiles\daily_file.txt" -NewName "monday_file.txt"