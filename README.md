# AbuseIPDB with mikrotik
Simple script to work abuseipdb.com with Mikrotik over SSH

## Usage

Add script to cron and run everyday (in free plan you have 5 api get every day)

My crontab entry (run at 6:00, 12:00, 18:00, 23:00):
0 6,12,18,23 * * * /srv/mt/abusedb.sh >/dev/null 2>&1

You'll also need firewall rule (in my case i have 1ip per ppp session so i add all-ppp in in-interface):  

`/ip firewall filter`

`add action=drop chain=input in-interface=all-ppp log=yes log-prefix=abuseipdb src-address-list=abuseidb`

Or add to filter raw - block input and output traffic:

`/ip firewall raw`

`add action=drop chain=prerouting comment="Drop annything coming from abuseidb" log=yes log-prefix=abuseipdb-raw src-address-list=abuseidb`

`add action=drop chain=prerouting comment="Drop annything going to abuseidb" dst-address-list=abuseidb log=yes log-prefix=abuseipdb-raw-out`


## TODO
- Change login from user/pass to keys
- Add Mikrotik credentials to variables
