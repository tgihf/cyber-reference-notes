# Ping Sweeping in PowerShell

## Perform a Ping Sweep

```powershell
1..254 | % { Test-Connection -Count 1 -ComputerName 10.10.10.$_ -Quiet }
```
