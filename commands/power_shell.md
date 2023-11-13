## Power Shell

### Processes

To stop all process with name
```
Stop-Process -Name "java" -Force
```

To find and kill process by TCP or UDP port
```
Get-Process -Id (Get-NetTCPConnection -LocalPort 8080).OwningProcess
Stop-Process -Id <ID>
```
or 
```
Get-Process -Id (Get-NetUDPEndpoint -LocalPort 8080).OwningProcess
Stop-Process -Id <ID>
```

### Wi-Fi networks

To see a list of all WiFi networks ever connected
```
netsh wlan show profile
```

To see WiFi network details
```
netsh wlan show profile "network_name"
```

To see WiFi network details with password
```
netsh wlan show profile "network_name" key=clear
```

### Zip archives

Zip files
```
Compress-Archive -Path C:\SOURCE\* -CompressionLevel Optimal -DestinationPath C:\DESTINATION\FILE.zip
```

Add more files to zip
```
Compress-Archive -Path C:\SOURCE\* -Update -DestinationPath C:\DESTINATION\FILE.zip
```

Unzip files
```
Expand-Archive -Path C:\SOURCE\FILE.zip -DestinationPath C:\DESTINATION
```
