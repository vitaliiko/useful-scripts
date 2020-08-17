#### To generate PGP key pair
Start key generation promt and select default options
```
gpg --full-generate-key
```

List existing keys to find generated key ID:
```
gpg --list-secret-keys --keyid-format LONG
```

Example result:
```
/Users/user/.gnupg/secring.gpg
------------------------------------
sec   4096R/3AA5C34371567BD2 2016-03-10 [expires: 2017-03-10]
uid                          user
ssb   4096R/42B317FD4BA89E7A 2016-03-10
```

`3AA5C34371567BD2` is key ID. Use it to export public/private keys:
```
gpg --armor --export <key-id> > pubkey.asc
gpg --export-secret-keys --armor <key-id> > privkey.asc
```

#### To encrypt file
```
gpg --output doc.csv.pgp --encrypt -r <recipient-email> doc.csv
```

#### To decrypt file
```
gpg --output doc.csv --decrypt doc.csv.pgp
```
