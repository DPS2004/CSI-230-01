#!bin/bash
allLogs=""
file="/var/log/apache2/access.log"

function getAllLogs(){
allLogs=$(cat "$file" | cut -d' ' -f1,3,7,12 | tr -d "[")
}

pageCountResults=""
function pageCount(){
pages=$(echo "$allLogs" | cut -d' ' -f3)
pageCountResults=$(echo "$pages" | sort | uniq -c)
}

function countingCurlAccess(){
curls=$(echo "$allLogs" | cut -d' ' -f1,4)
result=$(echo "$curls" | grep "curl" | sort | uniq -c)
echo "$result"
}

getAllLogs
pageCount
countingCurlAccess
#echo "$pageCountResults"

#echo "$allLogs"
