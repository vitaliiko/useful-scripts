## PowerShell

### Processes

To stop all process with name
```shell
Stop-Process -Name "java" -Force
```

To find and kill process by TCP or UDP port
```shell
Get-Process -Id (Get-NetTCPConnection -LocalPort 8080).OwningProcess
Stop-Process -Id <ID>
```
or 
```shell
Get-Process -Id (Get-NetUDPEndpoint -LocalPort 8080).OwningProcess
Stop-Process -Id <ID>
```

### Wi-Fi networks

To see a list of all Wi-Fi networks ever connected
```shell
netsh wlan show profile
```

To see Wi-Fi network details
```shell
netsh wlan show profile "network_name"
```

To see Wi-Fi network details with password
```shell
netsh wlan show profile "network_name" key=clear
```

### Zip archives

Zip files
```shell
Compress-Archive -Path C:\SOURCE\* -CompressionLevel Optimal -DestinationPath C:\DESTINATION\FILE.zip
```

Add more files to zip
```shell
Compress-Archive -Path C:\SOURCE\* -Update -DestinationPath C:\DESTINATION\FILE.zip
```

Unzip files
```shell
Expand-Archive -Path C:\SOURCE\FILE.zip -DestinationPath C:\DESTINATION
```
