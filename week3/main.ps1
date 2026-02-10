. (Join-Path $PSScriptRoot functions.ps1)

$loginoutsTable = getDaysLoginOut 14
$loginoutsTable

$shutdownTable = getShutdownStartups 14 $false
$shutdownTable

$startupTable = getShutdownStartups 14 $true
$startupTable