# https://stackoverflow.com/questions/44509704/creating-powershell-modules-from-multiple-files-referencing-with-module 
$Public = @(Get-ChildItem -Path $PSScriptRoot\public\*.ps1 -ErrorAction SilentlyContinue)
$Private = @(Get-ChildItem -Path $PSScriptRoot\private\*.ps1 -ErrorAction SilentlyContinue)

#Dot source the files
Foreach($import in @($Public + $Private))
{
    Try
    {
        . $import.fullname
    }
    Catch
    {
        Write-Error -Message "Failed to import function $($import.fullname): $_"
    }
}

Export-ModuleMember -Function $Public.Basename