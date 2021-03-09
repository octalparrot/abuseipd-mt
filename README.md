# AbuseIPDB with mikrotik
Simple script to work abuseipdb.com with Mikrotik over SSH

## Usage

Add script to cron and run everyday (in free plan you have 5 api get every day)

/path/to/file/abusedb.sh

You'll also need firewall rule (in my case i have 1ip per ppp session so i add all-ppp in in-interface):  
`/ip firewall filter add action=drop chain=input in-interface=all-ppp log=yes log-prefix=abuseipdb src-address-list=abuseidb`

## TODO
- Change login from user/pass to keys
- Add Mikrotik credentials to variables
