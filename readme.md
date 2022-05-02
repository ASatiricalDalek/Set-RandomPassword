# Sub Account Passwords

## Full details on the Oak Park School team drive under "AD Stuff/Sub Account Passwords workflow"

# Rational
Substitute teacher accounts are generic and shared with many people rotating in and out of the district. This creates a security risk as those passwords can easily be shared and are unable to be traced back to any particular user.

This script and workflow will randomize the sub account password on a set timeline (as of writing, one week) and place that information in a shared folder that only building administrators have access to. 

This approach is still not perfect (storing passwords in plaintext is still bad) but it does add some additional security beyond hoping that subs don’t share this info when they leave the district for the day.

# Adding Additional Accounts Users
The script uses the CSV files as both input and output to cut down on complexity. Simply add the UPN of the additional accounts to the “Login” column on the CSV and the next time the script is run it will grab that account as well. 

# Technical Details
The random password is generated from a collection of phrases defined in the passphrases list. There should be enough in here to provide a sufficiently random password but more additions are always good.

Every phrase in the passphrase block starts with an uppercase letter and has all lowercase letters after it. Each phrase is broken up with a -. This provides 3 separate characters for complexity requirements (Upper case, lower case, symbol). A trailing 2 digit number between 10 and 99 is also added to the end of the password by default to provide an additional complexity factor. This can be omitted using the -NoTrailingNumber switch. 

The Get-RandomPassword function has a few different options that are not used in the Set-SubAccounts script. (These are documented in the Get-Help of the function) 

-Phrases 
This sets the number of phrases to pull from the list. Note that this can be overridden if the password is not long enough to meet complexity requirements. Default is 3

-NoTrailingNumber
Providing this will generate a password without a trailing number

-MinimumPasswordLength
This is a failsafe to ensure that the password will meet ADs length requirements and not error out. If the minimum length is not met after the original pass another word will be added to the end of the password. This will continue until the new password meets length requirements. Default is 13. 
