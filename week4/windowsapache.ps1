$logs = Get-Content C:\xampp\apache\logs\access.log | Select-String "404" | select -ExpandProperty Line
$ipRegex = "\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b"
$ips = $logs | Select-String -Pattern $ipRegex -AllMatches  | ForEach-Object {$_.Matches} | ForEach-Object {$_.Value}
$ips | Group-Object