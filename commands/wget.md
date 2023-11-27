## Wget

Download and set the output file name
```bash
wget -O filename.zip http://www.domain.com/filename.zip
```

Download in background
```bash
wget -b http://www.domain.com/filename.zip
```

Download multiple files by links in a file
```bash
wget -i filename.txt
```

Download files by links in HTML file
```bash
wget --force-html -i filename.html
```
Add `<base href="/support/knowledge_base/">` if links are relative

Limit download speed 
```bash
wget --limit-rate=200k http://www.domain.com/filename.tar.gz
```

Download with login and password
```bash
wget --user=username --password='password' ftp://ftp.com/...
```
