. (Join-Path $PSScriptRoot functions.ps1)

$fullTable = getClasses

$fullTable = daysTranslator($fullTable)

<#
$fullTable  | Where-Object {
    $_.Instructor -ilike "Furkan Paligu"
}
#>
<#
$fullTable | Where-Object {`
    $_.Location -ilike "FREE 105" -and`
    $_.days -icontains "Wednesday"
} | Select-Object "Time Start", "Time End", "Class Code"
#>

$ITSInstructors = $fullTable | Where-Object {`
    ($_."Class Code" -ilike "SYS*") -or `
    ($_."Class Code" -ilike "NET*") -or `
    ($_."Class Code" -ilike "SEC*") -or `
    ($_."Class Code" -ilike "FOR*") -or `
    ($_."Class Code" -ilike "CSI*") -or `
    ($_."Class Code" -ilike "DAT*")`
} | Select-Object "Instructor"`
| Sort-Object "Instructor" -Unique

#ITSInstructors


$ITClasses = $fullTable | Where-Object {`
    $_.Instructor -in $ITSInstructors.Instructor`
} 

$ITClasses.Instructor | Group-Object -NoElement | Sort-Object "Count" -Descending