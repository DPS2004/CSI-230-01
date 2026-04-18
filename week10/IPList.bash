#!bin/bash
[ "$#" -eq 0 ] && echo "Usage: $0 <prefix>" && exit 1
prefix="$1"

[ "${#prefix}" -lt 5 ] && \
echo "Prefix is too short" && \
exit 1

for i in {0..255}
do
    ping -c 1 -W 1 $prefix.$i | grep "64 bytes" -q && \
    echo "$prefix.$i"
done
