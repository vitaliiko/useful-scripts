## Networking

Find Open Ports:
```bash
  netstat -tulpn
  netstat -tlpn # Just TCP ports
  netstat -ulpn # Just UDP ports
```

Specific port check
```bash
sudo netstat -lpn | grep :8080
```

Print IP address of a domain
```bash
dig +short google.com
```

Print my public IP address
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

Check access to some endpoint
```bash
nc -v -z -w 2 localhost 80
```
