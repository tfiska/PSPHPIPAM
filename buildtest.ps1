while (Get-Module -Name PSPHPIPAM) {Remove-Module PSPHPIPAM  -Verbose:$false } ; 
$ModuleImport=import-module "C:\Users\tryfis\OneDrive - Aker BP\Documents\GitHub\PSPHPIPAM\PSPHPIPAM\PSPHPIPAM.psm1" -force -PassThru

$Params = @{
    Path = "$PSScriptRoot\PSPHPIPAM\PSPHPIPAM.psd1"
    Author = "$(git config --get user.name)"
    CompanyName = "."
    Copyright = '(c) 2024 tfiska. All rights reserved. forked from yoke88'
    PowerShellVersion = "$($PsversionTable.PSVersion.Major).$($PsversionTable.PSVersion.Minor)"
    AliasesToExport = @($($ModuleImport.ExportedAliases.Keys))
    FunctionsToExport = @($($ModuleImport.ExportedFunctions.Keys))
  }


  Update-ModuleManifest @Params 