. (Join-Path $PSScriptRoot functions.ps1)

$tableRecords = getApacheLogs
Write-Host ($tableRecords | Format-Table -AutoSize | Out-String)

Write-Host ($tableRecords | Where-Object {
    $_.Referrer -ilike "*index.html*"` -and `
    $_.Page -ilike "*page2.html*" `
}`
| Format-Table -AutoSize | Out-String)