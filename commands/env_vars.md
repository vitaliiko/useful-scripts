## Environment variables

### envsubst
To replace env vars in a file
```bash
envsubst < "config.env.sample" > "config.env"
```

To replace only specified env vars in a file
```bash
envsubst '$VAR1 $VAR2' < "config.env.sample" > "config.env"
```

To replace all env vars found in file
```bash
envsubst "$(printf '${%s} ' $(env | cut -d'=' -f1))" < config.env
```

### Export
Export environment variables from script
```bash
. script-with-export-inside.sh
```
