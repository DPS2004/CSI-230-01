$ethernet = (Get-NetIPAddress -AddressFamily IPv4 | Where-Object{$_.InterfaceAlias -ilike "Ethernet*"})
$ethernet.IPAddress
$ethernet.PrefixLength

# Get-WmiObject -List | Where-Object{$_.name -ilike "Win32_Net*"} | Sort-Object

Get-CimInstance Win32_NetworkAdapterConfiguration -Filter "DHCPEnabled=true" | select DHCPServer | Format-Table -HideTableHeaders

(Get-DnsClientServerAddress -AddressFamily IPv4 | `
Where-Object{$_.InterfaceAlias -ilike "Ethernet*"}).ServerAddresses[0]

cd $PSScriptRoot

$files = (Get-ChildItem)
for ($j=0; $j -le $files.Count; $j++){
    if ($files[$j].Name -ilike "*ps1"){
        Write-Host $files[$j].Name
    }
}

$folderPath = "$PSScriptRoot\outfolder"
if(Test-Path $folderPath){
    Write-Host "The folder already exists"
}
else{
    New-Item -ItemType Directory -Path $folderPath
}

$filePath = Join-Path -Path $folderPath -ChildPath "out.csv"
$files | Where-Object{$_.Extension -eq ".ps1"} |`
Export-Csv -Path $filePath

$files = (Get-ChildItem -Path $folderPath)
$files | Rename-Item -NewName { $_.Name -replace ".csv", ".log"} -Force
Get-ChildItem -Recurse -File