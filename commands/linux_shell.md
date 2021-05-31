## Useful Shell Commands

#### Find open ports in the system
```
netstat -tulpn
netstat -tlpn # Just TCP ports
netstat -ulpn # Just UDP ports
```

#### Specific port check
```
sudo netstat -lpn | grep :8080
```

#### Go to the script's home directory
```
cd ${0%/*} 
```

#### Get current date in a certain format
```
date '+%Y-%m-%d %H:%M:%S'
```

#### Get uniq set of lines
```
<input> | sort | uniq
or 
<input> | sort -u
```

#### Count non empty lines
```
<input> | sed '/^\s*$/d' | wc -l
```

#### Sort lines of numbers in reverse order
```
<input> | sort -rn
```

#### Kill all processes with a certain name
```
ps aux | awk '/<app>/ {print $2}' | xargs kill
```

#### Print IP address of a domain
```
dig +short google.com
```

#### Print my public IP address
```
dig +short myip.opendns.com @resolver1.opendns.com
```
or
```
dig TXT +short o-o.myaddr.l.google.com @ns1.google.com
```

#### Export environment variables from script
```
. script-with-export-inside.sh
```

#### Get current system logs
```
sudo tail -f /var/log/syslog
```

#### To monitor disk IO performance 
```
iotop -o
```

#### Uppercase string
```
string=some text
echo ${string^^}
```

#### To find a location of some program installation
```
whereis <tool name>

e.g.
whereis docker
```

#### To replace env vars in a file
```
envsubst < "config.env.sample" > "config.env"
```

#### To replace only specified env vars in a file
```
envsubst '$VAR1 $VAR2' < "config.env.sample" > "config.env"
```

#### Set max virtual memory areas
```
vm.max_map_count=262144
```

#### Exclude directories from file list
```
find . -maxdepth 1 -not -type d
```
