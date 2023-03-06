<#
    .SYNOPSIS
    Reset the account password based on a CSV

    .DESCRIPTION
    Read in a CSV and change the account password for the account listed in that CSV. Rewrite the information back out to that CSV for user's to retrieve. 

    .PARAMETER CSVLocation
    The file path of the CSV containing the user's account name and current password

    .PARAMETER 

#>
function Set-OSSubAccountPassword
{
    param
    (
        [Parameter(Mandatory=$True)]
        $CSVLocation,
        [Parameter(Mandatory=$false)]
        [pscredential]
        $Credential
    )

    $subAccounts = Import-Csv -Path $CSVLocation
    $results = New-Object System.Collections.ArrayList
    
    foreach ($account in $subAccounts) 
    {
        $upn = $account.Login
        $ADAccount = Get-ADUser -Filter "userPrincipalName -like '$upn'"
        $NewPass = Get-RandomPassword
        if ($Credential) 
        {
            try 
            {
                Set-ADAccountPassword -Identity $ADAccount.SamAccountName -NewPassword (ConvertTo-SecureString $NewPass -AsPlainText -Force) -Credential $Credential   
            }
            catch 
            {
                Out-Default -InputObject "Unable to change password on $upn `n $error[0]" 
                break
            }
        }
        else 
        {
            try
            {
                Set-ADAccountPassword -Identity $ADAccount.SamAccountName -NewPassword (ConvertTo-SecureString $NewPass -AsPlainText -Force)
            }
            catch
            {
                Out-Default -InputObject "Unable to change password on $upn `n $error[0]" 
                break
            }
        }

        $AccountInfo = New-Object System.Object
        $AccountInfo | Add-Member -MemberType NoteProperty -Name "Login" -Value $upn
        $AccountInfo | Add-Member -MemberType NoteProperty "Password" -Value $NewPass
        $results.Add($AccountInfo) | Out-Null
    }

    $results | Export-Csv -Path $CSVLocation -NoTypeInformation

}