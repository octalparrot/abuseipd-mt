#!/bin/bash

PLIK=/tmp/abuseidb.txt
MT_PLIK=/tmp/abuseidb.rsc

rm -rf $PLIK
rm -rf $MT_PLIK

curl -G https://api.abuseipdb.com/api/v2/blacklist -d confidenceMinimum=90 -H "Key:$YOUR_API_KEY" -H "Accept: text/plain" -o $PLIK

echo "/ip firewall address-list" >> $MT_PLIK
echo "/ip firewall address-list remove [/ip firewall address-list find list=abuseidb]" >> $MT_PLIK

while IFS= read -r ip
do
echo "add list=abuseidb address=$ip timeout=2d" >> $MT_PLIK
done < "$PLIK"

sshpass -p "$MT_PASSWORD" scp -P $MT_PORT -r $MT_PLIK $MT_LOGIN@$MT_HOST:/abuseidb.rsc
sshpass -p "$MT_PASSWORD" ssh -o StrictHostKeyChecking=no -oHostKeyAlgorithms=+ssh-dss -p $MT_PORT -l $MT_LOGIN $MT_HOST /import abuseidb.rsc
