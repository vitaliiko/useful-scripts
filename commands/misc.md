## Miscellaneous

### System Information
Get current system logs
```bash
sudo tail -f /var/log/syslog
```

To monitor disk IO performance 
```bash
iotop -o
```

Memory consumption analysis
* free -h
* top
* htop

Go to the script's home directory
```bash
cd ${0%/*} 
```

### Print
Get current date in a certain format
```bash
date '+%Y-%m-%d %H:%M:%S'
```

Get random set of characters
```bash
tr -dc a-z0-9 < /dev/urandom | head -c 10
```

Uppercase string
```bash
echo ${$string^^}
```

Trim white spaces in string
```bash
echo $string | tr -d ' '
```

Print the exit status of the last executed command
```bash
echo $?
```

### Directories
To find a location of some program installation
```bash
whereis <tool name>

e.g.
whereis docker
```

To analyze directories space consumption
```bash
sudo du -shx /* | sort -h
```

### Configuration
Set max virtual memory areas
```bash
vm.max_map_count=262144
```

### Process Management
Kill all processes with a certain name
```bash
ps aux | awk '/<app>/ {print $2}' | xargs kill
```
