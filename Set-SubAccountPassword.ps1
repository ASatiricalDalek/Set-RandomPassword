Import-Module ".\Get-RandomPassword.psm1"

# File locations for sub account CSVs
$EES = "\\OakShares\SubAccounts\Einstein\EES.csv"
$KES = "\\OakShares\SubAccounts\Key\KES.csv"
$LES = "\\OakShares\SubAccounts\Lessenger\LES.csv"
$NOVA = "\\OakShares\SubAccounts\NOVA\NOVA.csv"
$OPHS = "\\OakShares\SubAccounts\OPHS\OPHS.csv"
$OPPA = "\\OakShares\SubAccounts\OPPA\OPPA.csv"
$PES = "\\OakShares\SubAccounts\Pepper\PES.csv"
$TEST = "\\OakShares\SubAccounts\Test\Test.csv"

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
# Set-SubAccountPassword -CSVLocation $EES
# Set-SubAccountPassword -CSVLocation $KES
# Set-SubAccountPassword -CSVLocation $LES
# Set-SubAccountPassword -CSVLocation $NOVA
# Set-SubAccountPassword -CSVLocation $OPHS
# Set-SubAccountPassword -CSVLocation $OPPA
# Set-SubAccountPassword -CSVLocation $PES