## Useful Shell Commands

#### Find open ports in the system
```bash
netstat -tulpn
netstat -tlpn # Just TCP ports
netstat -ulpn # Just UDP ports
```

#### Specific port check
```bash
sudo netstat -lpn | grep :8080
```

#### Go to the script's home directory
```bash
cd ${0%/*} 
```

#### Get current date in a certain format
```bash
date '+%Y-%m-%d %H:%M:%S'
```

#### Get unique set of lines
```bash
<input> | sort | uniq
or 
<input> | sort -u
```

#### Count non empty lines
```bash
<input> | sed '/^\s*$/d' | wc -l
```

#### Sort lines of numbers in reverse order
```bash
<input> | sort -rn
```

#### Get random set of characters
```bash
tr -dc a-z0-9 < /dev/urandom | head -c 10
```

#### Kill all processes with a certain name
```bash
ps aux | awk '/<app>/ {print $2}' | xargs kill
```

#### Print IP address of a domain
```bash
dig +short google.com
```

#### Print my public IP address
```bash
dig +short myip.opendns.com @resolver1.opendns.com
```
or
```bash
dig TXT +short o-o.myaddr.l.google.com @ns1.google.com
```
or
```bash
curl https://ipinfo.io/ip
```

#### Export environment variables from script
```bash
. script-with-export-inside.sh
```

#### Get current system logs
```bash
sudo tail -f /var/log/syslog
```

#### To monitor disk IO performance 
```bash
iotop -o
```

#### Uppercase string
```bash
string=some text
echo ${string^^}
```

#### To find a location of some program installation
```bash
whereis <tool name>

e.g.
whereis docker
```

#### To replace env vars in a file
```bash
envsubst < "config.env.sample" > "config.env"
```

#### To replace only specified env vars in a file
```bash
envsubst '$VAR1 $VAR2' < "config.env.sample" > "config.env"
```

#### Set max virtual memory areas
```bash
vm.max_map_count=262144
```

#### Sort lines by amount of occurrences
```bash
cat ids.txt | sort | uniq -c | sort -r -g
```

#### Find rows with duplicates in first column
```bash
<input> | awk -F, '{print $1}' | sort | uniq -c | awk '{if ($1 > 1) print $1" "$2}' | sort -rg
```

#### To analyze directories space consumption
```bash
sudo du -shx /* | sort -h
```

#### Memory consumption analysis
* free -h
* top
* htop

#### Resolve `/bin/bash^M: bad interpreter` issue
```bash
sed -i -e 's/\r$//' your_script.sh
```

#### Check access to some endpoint
```bash
nc -v -z -w 2 localhost 80
```

#### Print the exit status of the last executed command
```bash
echo $?
```
