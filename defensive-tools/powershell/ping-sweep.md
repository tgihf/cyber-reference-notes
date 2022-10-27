# Ping Sweeping in PowerShell

## Ping Sweep a /24 Network

```powershell
1..254 | % { Test-Connection -Count 1 -ComputerName 10.10.10.$_ -Quiet }
```
