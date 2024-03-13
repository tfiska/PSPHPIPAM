

$Params = @{
    Path = "$PSScriptRoot\PSPHPIPAM\PSPHPIPAM.psd1"
    Author = "$(git config --get user.name)"
    CompanyName = "."
    Copyright = '(c) 2024 tfiska. All rights reserved. forked from yoke88'
    PowerShellVersion = "$($PsversionTable.PSVersion.Major).$($PsversionTable.PSVersion.Minor)"
  }


  Update-ModuleManifest @Params