# [recon-ng](https://github.com/lanmaster53/recon-ng)

> `recon-ng` is modular framework for open source web-based reconnaissance quickly and thoroughly. Its interface is much like that of the Metasploit Framework. It contains modules for interacting with many of the popular OSINT sources and in many ways represents a one-stop shop for OSINT researchers.

---

## Search the Marketplace

The marketplace contains all the existing modules.

```bash
[recon-ng][default] > marketplace search
```

---

## Install a Module from the Marketplace

```bash
[recon-ng][default] > marketplace install $MODULE_PATH
```

- `$MODULE_PATH` example: `recon/domains-hosts/hackertarget`

---

## Load a Module

```bash
[recon-ng][default] > modules load $MODULE_PATH
```

---

## Unload the Current Module

```bash
[recon-ng][default][$MODULE] > back
```

---

## View the Currently Loaded Module's Information

```bash
[recon-ng][default][$MODULE] > info
```

---

## View the Currently Loaded Module's Options

```bash
[recon-ng][default][$MODULE] > options
```

---

## Set One of the Currently Loaded Module's Options

```bash
[recon-ng][default][$MODULE] > options set $OPTION_NAME $OPTIONA_VALUE
```

---

## Run the Current Module

```bash
[recon-ng][default][$MODULE] > run
```

---

## Show Finding Categories

`recon-ng` stores each of the modules' findings in database tables like `companies`, `contacts`, `credentials`, `domains`, and more. To view all the different options:

```bash
[recon-ng][default] > show ?
```

---

## Show Findings

```bash
[recon-ng][default] > show $FINDING_CATEGORY
```

- `$FINDING_CATEGORY` can be one of the categories listed [[recon-ng#Show Finding Categories|here]]
