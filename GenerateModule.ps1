# Run to generate .psd1 file for module import
New-ModuleManifest `
-Path $PSScriptRoot\OSADPasswords.psd1 `
-RootModule .\OSADPasswords.psm1 `
-ModuleVersion "2.0" `
-Author "Connor McNamara" `
-CompanyName "Oakland Schools" `
-Description "Functions for random setting and recording of AD Account passwords for temporary generic accounts (and other password related utilities)" `
-PowerShellVersion "7.1" `
-FunctionsToExport @('Get-OSRandomPassword', 'Set-OSSubAccountPassword') `