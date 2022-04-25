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
        $Password    
    )
    Test-OSCredentials
    Set-ADAccountPassword -Identity $User -NewPassword (ConvertTo-SecureString -AsPlainText $Password -Force) -Credential $cred
}