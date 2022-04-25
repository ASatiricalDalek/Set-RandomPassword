<#
    .SYNOPSIS 
    Sets admin password for the script

    .DESCRIPTION
    Sets the admin password for the script to use in resetting the users's password
#>
function Set-OSCredential
{
    param
    (
        $username
    )

    write-host "Enter your A account credentials"
    # Allow the user to provide their username but if they don't just use the full get-credential dialog
    if ($username)
    {
        $script:Cred = Get-Credential -UserName $username
    }
    else 
    {
        $script:Cred = Get-Credential   
    }
}

<#
    .SYNOPSIS 
    Verifies a user has initialized the module with their admin credentials

    .DESCRIPTION
    Checks to see if the $cred variable has been set for this instance of the module. If it hasn't, run the set-oscredential function to get it
#>
function Test-OSCredentials
{
    if ($null -eq $Cred)
    {
        Set-OSCredential
    }
}

<#
    .SYNOPSIS 
    Generates a random password

    .DESCRIPTION
    Generates a random password based on a list of passphrases randomly arranged. The number of phrases, minimum length, and whether or not to include a number can be customized

    .PARAMETER Phrases
    How many phrases you want the password to contian, each separated my a -. Default is 3

    .PARAMETER NoTrailingNumber
    Switch parameter. Using it removes the trailing two-digit number from the final password

    .PARAMETER MinimumPasswordLength
    Sets the minimum length of the password, will override number of phrases if the password is too short
#>
function Get-RandomPassword
{
    param (
        [Parameter()]
        [Int32]$Phrases = 3,

        [Parameter()]
        [switch]$NoTrailingNumber,

        [Parameter()]
        [Int32]$MinimumPasswordLength = 13
    )

    $passphrases = 
    @(
        'Dog', 'Cat', 'Walrus', 'Shark', 'Apple', 'Wonder', 'Glue', 'Castle', 'Spider', 'Hornet', 'Rose', 'Candy', 'Seashell', 'Rabbit', 'Pink', 'Red', 'Orange', 'Yellow', 'Blue', 'Purple', 
        'Cyan', 'Change', 'Control', 'Security', 'Maximum', 'Rhino', 'Harry', 'Alpaca', 'Alps', 'Michigan', 'Oak', 'Park', 'Network', 'Education', 'Electricty', 'Harbor', 'Town', 'Alien', 
        'Deleted', 'Ticket', 'River', 'Mountain', 'Canyon', 'Rapid', 'Rustic', 'Vintage', 'Modern', 'Score', 'Waiter', 'Somber', 'Operation', 'Excited', 'Random', 'Begin', 'Watch', 'Phone',
        'Disc', 'Dino', 'Zoom', 'Speed', 'Grace', 'Bonfire', 'Raptor', 'Gound', 'Dock', 'Monitor', 'Keyboard', 'Watch', 'Listen', 'Look', 'Ocean', 'Climate', 'Variation', 'Weather'
    )
    $randomPW = $null
    $loopControl = 1
    # Continue looping until the number of phrases and minimum length of password is met
    while ($loopControl -le $Phrases -or $randomPW.Length -lt $MinimumPasswordLength) 
    {
        $random = $null
        $random = Get-Random -Minimum 0 -Maximum $passphrases.Length
        if ($randomPW)
        {
            $randomPW = $randomPW + "-" + $passphrases[$random]
        }
        else
        {
            $randomPW = $passphrases[$random]
        }
        $loopControl += 1     
    }

    # Add a trailing number between 10 and 99 (provided the user wanted one)
    if($NoTrailingNumber -eq $false)
    {
        $trailingNumber = Get-Random -Minimum 10 -Maximum 99
        $randomPW = $randomPW + "-" + $trailingNumber.ToString()
    }

    return $randomPW
}

function Set-RandomPassword 
{
    param 
    (
        $User,
        [securestring]$Password    
    )
    Test-OSCredentials
    Set-ADAccountPassword -Identity $User -NewPassword $Password -Credential $cred
}

