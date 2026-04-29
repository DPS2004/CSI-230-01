#! /bin/bash

# This is the link we will scrape
link="10.0.17.6/IOC.html"

# get it with curl and tell curl not to give errors
fullPage=$(curl -sL "$link")

# Utilizing xmlstarlet tool to extract table from the page
table1=$(echo "$fullPage" | \
xmlstarlet format --html --recover 2>/dev/null | \
xmlstarlet select --template --copy-of \
"(//html//body//table)[1]//tr//td")

table1=$(echo "$table1" | sed 's/<\/tr>/\n/g' | \
                     sed -e 's/&amp;//g' | \
                     sed -e 's/<tr>//g' | \
                     sed -e 's/<td[^>]*>//g' | \
                     sed -e 's/<\/td>/;/g' | \
                     sed -e 's/<[/\]\{0,1\}a[^>]*>//g' | \
                     sed -e 's/<[/\]\{0,1\}nobr>//g')
#echo "$table1"

justSemicolons="${table1//[^;]}"
tableSize="${#justSemicolons}"

:> IOC.txt
for ((i=1; i<=$tableSize; i+=2)); do
    thing=$(echo "$table1" | cut -d';' -f$i)
    echo "$thing" >> IOC.txt

done




