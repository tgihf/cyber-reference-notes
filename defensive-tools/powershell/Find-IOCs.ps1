$ipRange = 254..2 | % {"10.10.10.$_"}
$scanResults = $ipRange | % { Get-CimInstance -ClassType Win32_PingStatus -Filter "Address='$_' and Timeout=100" | Select-Object -Property Address, StatusCode }

$fileIOCs = cat "C:\Users\DCI Student\Downloads\files.txt"
$ipIOCs = cat "C:\Users\DCI Student\Downloads\ips.txt"
$regIOCs = cat "C:\Users\DCI Student\Downloads\reg.txt"

Set-NetConnectionProfile -InterfaceAlias * -NetworkCategory Private
ForEach ($result in $scanResults) {
    Set-Item -Path WSMan:\localhost\Client\TrustedHosts -Value $result.Address

    Write-Host "[*] Attempting to connect to $($result.Address)"
    $s = New-PSSession -ComputerName -$result.Address -Credential (Get-Credential)

    if ($s) {
        Invoke-Command -Session $s -ArgumentList $result.Address, $fileIOCs, $ipIOCs, $regIOCs -ScriptBlock {
            param($ip, $fileIOCs, $ipIOCs, $regIOCs)

            # Search for file IOCs
            ForEach ($file in $fileIOCs) {
                $file = $file.Replace("%TEMP%", $env:TEMP).Replace("%USERPROFILE%", $env:USERPROFILE).Replace("%USERAPPDATA%", $env:LOCALAPPDATA).Replace("%PROGRAMS%", $env:ProgramFiles)
                if (Get-ChildItem -Path $file -ErrorAction SilentlyContinue -Force) {
                    Write-Host "[*][$ip] Found file IOC $file"
                }
            }

            # Search for registry IOCs
            ForEach ($key in $regIOCs) {
                $elements = $key.Split("\")
                $path = $elements[0..($elements.Count - 2)] -join "\"
                $k = $elements[-1].Replace('"', '')

                if ((Get-Item Registry::$path).Property.Contains($k)) {
                    Write-Host "[*][$ip] Found registry IOC $path\$k"
                }
            }

            $ Search for IP IOCs
            $connections = Get-NetTCPConnection | % {$_.RemoteAddress}
            ForEach ($addr in $ipIOCs) {
                if ($connections.Contains($addr)) {
                    Write-Host "[*][$ip] Found IP IOC $addr"
                }
            }
        }
    }
}