#!bin/bash
MYIP=$(ip addr | awk '{print $2}' | sed -n '10 p' | cut -d/ -f1)

echo "$MYIP"
