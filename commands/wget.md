#### Download and set the output file name
```
wget -O filename.zip http://www.domain.com/filename-4.0.1.zip
```

#### Download in background
```
wget -b http://www.domain.com/filename-4.0.1.zip
```

#### Download multiple files by links in a file
```
wget -i filename.txt
```

#### Download files by links in HTML file
```
wget --force-html -i filename.html
```
Add `<base href="/support/knowledge_base/">` if links are relative

#### Limit download speed 
```
wget --limit-rate=200k http://www.domain.com/filename.tar.gz
```

#### Download with login and password
```
wget --user=username --password='password' ftp://ftp.com/...
```
