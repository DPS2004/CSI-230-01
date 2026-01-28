$loginouts = Get-EventLog System -source Microsoft-Windows-Winlogon -After (Get-Date).AddDays(-14)
$loginoutsTable = @()
for($i=0; $i -lt $loginouts.Count; $i++){
    $login = $loginouts[$i]
    $event = ""
    if($login.InstanceId -eq 7001) {$event="Logon"}
    if($login.InstanceId -eq 7002) {$event="Logoff"}

    $userId = $login.ReplacementStrings[1]
    $userObject = New-Object System.Security.Principal.SecurityIdentifier($userId)

    $loginoutsTable += [pscustomobject]@{`
        "Time" = $login.TimeGenerated; `
        "Id" = $login.EventID; `
        "Event" = $event; `
        "User" = $userObject.Translate([System.Security.Principal.NTAccount]).Value ;
    }
                                          
}

$loginoutsTable