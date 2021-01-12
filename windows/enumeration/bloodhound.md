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
./BloodHound --no-sandbox # no sudo required
```

Login using your neo4j credentials (in LastPass)

## Collection

Somehow, someway, execute a BloodHound collector (located in **/usr/share/Bloodhound/Collectors**) on a machine in the target domain.

**Attacker Machine, Python collector**:

```bash
bloodhound-python -d $DOMAIN -u $USERNAME -p $PASSWORD -c All -ns $DOMAIN_DNS_SERVER_IP
```

**Target Machine, PowerShell collector**:

```powershell
. .\SharpHound.ps1 # Source the script
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

## Ingest

Transfer the resultant ZIP archive to the attacker machine upload it to the BloodHound web UI, and explore!
