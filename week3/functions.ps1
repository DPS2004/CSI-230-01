function getDaysLoginOut($day){

$loginouts = Get-EventLog System -source Microsoft-Windows-Winlogon -After (Get-Date).AddDays(0 - $day)
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
return $loginoutsTable
}

function getShutdownStartups($day, $startup){
$event = "shutdown"
$eventid = 6006
if($startup){
    $eventid = 6005
    $event = "startup"
}

$events = Get-EventLog -LogName System -After (Get-Date).AddDays(0 - $day)
$eventsTable = @()
for($i=0; $i -lt $events.Count; $i++){
    $eventData = $events[$i]
    #$eventData.InstanceId -eq $eventid
    if($eventData.EventID -eq $eventid){
        $userId = $eventData.ReplacementStrings[1]
        #$userObject = New-Object System.Security.Principal.SecurityIdentifier($userId)

        $eventsTable += [pscustomobject]@{`
            "Time" = $eventData.TimeGenerated; `
            "Id" = $eventData.EventID; `
            "Event" = $event; `
            "User" = "System" ;
        }

    }
                                          
}
return $eventsTable
}

#$loginoutsTable