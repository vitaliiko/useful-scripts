#### To generate SSH key do the following

1. Run `ssh-keygen` to generate a key
1. Run `chmod 400 ~/.ssh/id_rsa` to prevent key modifications
1. Run `eval 'ssh-agent'` to start the ssh agent
1. Run `ssh-add ~/.ssh/<private_key_file>` to prevent password entering each time key is used
1. Optionally. Set up [config](https://github.com/vitaliykobrin/useful-scripts/blob/master/configs/ssh-config.yml) for multiple keys usage
1. Run `chmod 600 ~/.ssh/config` to allow read/write only to an owner


#### Copy file with scp
```
scp input.txt user@ip_adress:/home/user
```
or 
```
scp -i key.pem input.txt user@ip_adress:/home/user
```

#### Recursively send folder via ssh with excludings
```
rsync -rv -e "ssh -l user" --exclude 'node_modules' --exclude '*.log' ./folder ip_adress:/home/user
```

#### Use scp with password in a script
```
sshpass -p $password scp $source $destination
```
