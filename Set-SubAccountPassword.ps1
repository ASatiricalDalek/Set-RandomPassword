Import-Module "G:\My Drive\PSScripts\Set-RandomPassword\Get-RandomPassword.psm1"

# File locations for sub account CSVs
$EES = "G:\My Drive\PSScripts\Set-RandomPassword\Accounts\EES.csv"
$KES = "G:\My Drive\PSScripts\Set-RandomPassword\Accounts\KES.csv"
$LES = "G:\My Drive\PSScripts\Set-RandomPassword\Accounts\LES.csv"
$NOVA = "G:\My Drive\PSScripts\Set-RandomPassword\Accounts\NOVA.csv"
$OPHS = "G:\My Drive\PSScripts\Set-RandomPassword\Accounts\OPHS.csv"
$OPPA = "G:\My Drive\PSScripts\Set-RandomPassword\Accounts\OPPA.csv"
$PES = "G:\My Drive\PSScripts\Set-RandomPassword\Accounts\PES.csv"
$TEST = "G:\My Drive\PSScripts\Set-RandomPassword\Accounts\Test.csv"

$Cred = Get-Credential "amcnamarac"


function Set-SubAccountPassword
{
    param
    (
        $CSVLocation
    )

    $subAccounts = Import-Csv -Path $CSVLocation
    $results = New-Object System.Collections.ArrayList
    
    foreach ($account in $subAccounts) 
    {
        $upn = $account.Login
        $ADAccount = Get-ADUser -Filter "userPrincipalName -like '$upn'"
        $NewPass = Get-RandomPassword 
        Set-ADAccountPassword -Identity $ADAccount.SamAccountName -NewPassword (ConvertTo-SecureString $NewPass -AsPlainText -Force) -Credential $Cred

        $AccountInfo = New-Object System.Object
        $AccountInfo | Add-Member -MemberType NoteProperty -Name "Login" -Value $upn
        $AccountInfo | Add-Member -MemberType NoteProperty "Password" -Value $NewPass
        $results.Add($AccountInfo) | Out-Null
    }

    $results | Export-Csv -Path $CSVLocation -NoTypeInformation

}

Set-SubAccountPassword -CSVLocation $TEST