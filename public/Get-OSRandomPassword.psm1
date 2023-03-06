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
function Get-OSRandomPassword
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
        'Disc', 'Dino', 'Zoom', 'Speed', 'Grace', 'Bonfire', 'Raptor', 'Ground', 'Dock', 'Monitor', 'Keyboard', 'Watch', 'Listen', 'Look', 'Ocean', 'Climate', 'Variation', 'Weather'
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
