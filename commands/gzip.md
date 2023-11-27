## Gzip

#### Compress file(s)
```bash
gzip file.txt
```
or 
```bash
gzip file1.txt file2.txt file3.txt
```

#### Compress and keep original file
```bash
gzip -c file.txt > file.txt.gz
```
or
```bash
gzip -k file.txt
```

#### Compress all files in a directory including sud-directories
```bash
gzip -r *
```

#### Decompress file
```bash
gzip -d file.txt.gz
```
or
```bash
gunzip file.txt.gz
```

#### Decompress and keep original file
```bash
gunzip -c file.txt.gz > file.txt
```
or 
```bash
gzip -dk file.txt.gz > file.txt
```

#### To compress faster with less compression
```bash
gzip -1 file.txt
```
or
```bash
gzip --fast file.txt
```

#### To compress slowest with best compression
```bash
gzip -9 file.txt
```
or
```bash
gzip --best file.txt
```

#### Compress a directory
```bash
tar czvf etc.tar.gz /etc/
```
where 
* c = create a new tar archive
* z = use gzip
* v = verbose information
* f = specify file name
