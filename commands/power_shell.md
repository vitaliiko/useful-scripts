### To stop all process with name
```
Stop-Process -Name "java" -Force
```

### To find and kill process by TCP or UDP port
```
Get-Process -Id (Get-NetTCPConnection -LocalPort 8080).OwningProcess
Stop-Process -Id <ID>
```
or 
```
Get-Process -Id (Get-NetUDPEndpoint -LocalPort 8080).OwningProcess
Stop-Process -Id <ID>
```
