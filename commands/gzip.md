#### Compress file(s)
```
gzip file.txt
```
or 
```
gzip file1.txt file2.txt file3.txt
```

#### Compress and keep original file
```
gzip -c file.txt > file.txt.gz
```
or
```
gzip -k file.txt
```

#### Compress all files in a directory including sud-directories
```
gzip -r *
```

#### Decompress file
```
gzip -d file.txt.gz
```
or
```
gunzip file.txt.gz
```

#### Decompress and keep original file
```
gunzip -c file.txt.gz > file.txt
```
or 
```
gzip -dk file.txt.gz > file.txt
```

#### To compress faster with less compression
```
gzip -1 file.txt
```
or
```
gzip --fast file.txt
```

#### To compress slowest with best compression
```
gzip -9 file.txt
```
or
```
gzip --best file.txt
```

#### Compress a directory
```
tar czvf etc.tar.gz /etc/
```
where 
* c = create a new tar archive
* z = use gzip
* v = verbose information
* f = specify file name
