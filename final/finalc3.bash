#! /bin/bash

outFile="/var/www/html/report.html"

:> $outFile
echo "<html>" >> $outFile
echo "<head><style> th, td { border: 1px solid black; } </style></head>" >> $outFile
echo "<body>" >> $outFile
echo "Access logs with IOC indicators:" >> $outFile
echo "<table>" >> $outFile
echo "<tbody>" >> $outFile
#loop goes here
while IFS= read -r line; do
    echo "<tr>" >> $outFile

    for ((i=1; i<=3; i+=1)); do
        echo "<td>" >> $outFile
        echo "$line" | cut -d' ' -f$i  >> $outFile
        echo "</td>" >> $outFile
    done

    echo "</tr>" >> $outFile
done < "report.txt"

echo "</tbody>" >> $outFile
echo "</table>" >> $outFile
echo "</body>" >> $outFile
echo "</html>" >> $outFile
