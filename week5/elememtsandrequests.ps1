$page = Invoke-WebRequest -TimeoutSec 10 http://10.0.17.42/ToBeScraped.html

#$page.Links | Select-Object -Property outerText, href

#$h2s = $page.ParsedHtml.body.getElementsByTagName("h2") | Select-Object -Property outerText
#$h2s

$div1s = $page.ParsedHtml.body.getElementsByTagName("div") | where { `
    $_.getAttributeNode("class").Value -ilike "div-1" `
} | Select-Object -Property innerText

$div1s