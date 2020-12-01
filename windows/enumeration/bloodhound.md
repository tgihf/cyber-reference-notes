# [BloodHound](https://github.com/BloodHoundAD/BloodHound)

BloodHound uses graph theory to reveal the hidden and often unintended relationships within an Active Directory environment.

## Setup

**Attack machine**: Start neo4j

```bash
sudo service neo4j start
```

**Attack machine (must be GUI)**: Start Bloodhound

```bash
cd /usr/share/BloodHound-linux-x64
./Bloodhound --no-sandbox # no sudo required
```

Login using your neo4j credentials (in LastPass)

## Collection

Somehow, someway, execute a BloodHound collector (located in **/usr/share/Bloodhound/Collectors**) on a machine in the target domain.

**Target Machine, PowerShell collector**:

```powershell
. .\SharpHound.ps1 # Source the script
Invoke-BloodHound -CollectionMethod All -Domain {domain} -Stealth -NoSaveCache -CompressData # HYDRA.test
```

**Target Machine, C# Collector**:

```powershell
.\SharpHound.exe --CollectionMethod All --Domain {domain} -Stealth -NoSaveCache -CompressData # HYDRA.test
```

**Meterpreter on Target Machine**:

```powershell
meterpreter > use powershell
meterpreter > powershell_import {path to SharpHound.ps1}
meterpreter > powershell_execute "Invoke-BloodHound -CollectionMethod All -Domain {domain} -Stealth -NoSaveCache -CompressData" # HYDRA.test
```

## Ingest

Transfer the resultant ZIP archive to the attacker machine upload it to the BloodHound web UI, and explore!
