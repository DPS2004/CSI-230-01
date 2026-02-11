function getApacheLogs(){

$logs = Get-Content C:\xampp\apache\logs\access.log

$logTable = @()

for($i=0; $i -lt $logs.Count; $i++){
    $log = $logs[$i]
    #$log.split(" ")[5]
    #$log
    $logSplit = $log.split(" ")

    $logTable += [pscustomobject]@{`
        "IP" = $logSplit[0];
        "Time" = $logSplit[3];
        "Method" = $logSplit[5];
        "Page" = $logSplit[6];
        "Protocol" = $logSplit[7];
        "Response" = $logSplit[8];
        "Referrer" = $logSplit[10];
    }
}

return $logTable
}