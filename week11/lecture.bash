#!bin/bash
allLogs=""
file="/var/log/apache2/access.log"

function getAllLogs(){
allLogs=$(cat "$file" | cut -d' ' -f1,4,7 | tr -d "[")
}

pageCountResults=""
function pageCount(){
pages=$(echo "$allLogs" | cut -d' ' -f3)
pageCountResults=$(echo "$pages" | sort | uniq -c)
}

getAllLogs
pageCount
echo "$pageCountResults"

#echo "$allLogs"
