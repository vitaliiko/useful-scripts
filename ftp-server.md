### To run FTP server on Linux Mint

1. Install FTP service: `sudo apt-get update && sudo apt-get install -y vsftpd`
2. Update config in `/etc/vsftpd.conf` file to contain the following:

```
listen=NO
anonymous_enable=NO
local_enable=YES
write_enable=YES
local_umask=022
dirmessage_enable=YES
use_localtime=YES
xferlog_enable=YES
connect_from_port_20=YES
chroot_local_user=YES
secure_chroot_dir=/var/run/vsftpd/empty
pam_service_name=vsftpd
rsa_cert_file=/etc/ssl/certs/ssl-cert-snakeoil.pem
rsa_private_key_file=/etc/ssl/private/ssl-cert-snakeoil.key
ssl_enable=Yes
pasv_enable=Yes
pasv_min_port=10000
pasv_max_port=10100
allow_writeable_chroot=YES
ssl_tlsv1=YES
ssl_sslv2=NO
ssl_sslv3=NO
```

3. Run FTP server: `sudo systemctl start vsftpd.service`
4. Chech FTP server status: `sudo systemctl status vsftpd.service`
5. Add user: `sudo adduser <username>`
