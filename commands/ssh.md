## SSH

### To generate SSH key do the following
1. Run `ssh-keygen` to generate a key
1. Run `chmod 400 ~/.ssh/id_rsa` to prevent key modifications
1. Run ``eval `ssh-agent` `` to start the ssh agent
1. Run `ssh-add ~/.ssh/<private_key_file>` to prevent password entering each time key is used. (or run ``eval `ssh-agent -s`; ssh-add ~/.ssh/<private_key_file>`` in git shell on Windows)
1. Optionally. Set up [config](https://github.com/vitaliykobrin/useful-scripts/blob/master/configs/ssh-config.yml) for multiple keys usage
1. Run `chmod 600 ~/.ssh/config` to allow read/write only to an owner

To change SSH key password use
```bash
ssh-keygen -p -f ~/.ssh/id_rsa
```

### To generate RSA SSH key
```bash
ssh-keygen -t rsa -m PEM
```

### SCP
Copy file with scp
```bash
scp input.txt user@ip_adress:/home/user
```
or 
```bash
scp -i key.pem input.txt user@ip_adress:/home/user
```

Use scp with password in a script
```bash
sshpass -p $password scp $source $destination
```

### RSYNC
Recursively send folder via ssh but excluding some files
```bash
rsync -rv -e "ssh -l user" --exclude 'node_modules' --exclude '*.log' ./folder ip_adress:/home/user
```
