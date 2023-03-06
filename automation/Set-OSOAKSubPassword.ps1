# File locations for sub account CSVs
$EES = "\\OakShares\SubAccounts\Einstein\EES.csv"
$KES = "\\OakShares\SubAccounts\Key\KES.csv"
$LES = "\\OakShares\SubAccounts\Lessenger\LES.csv"
$NOVA = "\\OakShares\SubAccounts\NOVA\NOVA.csv"
$OPHS = "\\OakShares\SubAccounts\OPHS\OPHS.csv"
$OPPA = "\\OakShares\SubAccounts\OPPA\OPPA.csv"
$PES = "\\OakShares\SubAccounts\Pepper\PES.csv"
$TEST = "\\OakShares\SubAccounts\Test\Test.csv"

Set-SubAccountPassword -CSVLocation $TEST
Set-SubAccountPassword -CSVLocation $EES
Set-SubAccountPassword -CSVLocation $KES
Set-SubAccountPassword -CSVLocation $LES
Set-SubAccountPassword -CSVLocation $NOVA
Set-SubAccountPassword -CSVLocation $OPHS
Set-SubAccountPassword -CSVLocation $OPPA
Set-SubAccountPassword -CSVLocation $PES