#### Every 15 minutes except for 3:00-3:59
```
*/15 0-2,4-23 * * *
```
#### At 3:15, 3:30 and 3:45
```
15-45/15 3 * * *
```
#### At 3:00
```
0 3 * * *
```

#### To set up bacground cron job on linux
1. `crontab -e`
1. Add line with schedule and script to be performed
```
@weekly home/user/script.sh >> /home/user/logs.txt
```
This will run script weekly and write its output to a text file
