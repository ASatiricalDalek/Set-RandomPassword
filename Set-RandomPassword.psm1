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