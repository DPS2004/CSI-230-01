#! /bin/bash

if [ ! ${#} -eq 2 ]; then
    echo "Usage: bash finalc2.bash access.log IOC.txt"
    exit;
fi

logFile="$1"

cat "$logFile" | egrep -i -f $2 | cut -d ' ' -f1,4,7 | sed 's/\[//' > report.txt
