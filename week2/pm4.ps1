$chromes = Get-Process | Where-Object{$_.Name -ilike "*chrome*"}
$chromeCount = ($chromes | Measure-Object).Count
if($chromeCount -gt 0){
    Write-Host "Chrome is running, shutting it down"
    Stop-Process $chromes
}else{
    Write-Host "Starting Chrome"
    Start-Process "C:\Program Files\Google\Chrome\Application\chrome.exe" "Champlain.edu"
}