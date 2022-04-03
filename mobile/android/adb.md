# [Android Debug Bridge](https://developer.android.com/studio/command-line/adb)

> A versatile command-line tool that lets you communicate with a device. The `adb` command facilitates a variety of device actions, such as installing and debugging apps, and it provides access to a Unix shell that you can use to run a variety of commands on a device.

`adb` is installed on a separate machine and used to interact with an Android device via USB or remotely.

---

## `adb` Port

`adb` generally listens on the Android's devices TCP port 5555. It is often only accessible via `localhost`.

---

## Install `adb`

```bash
apt install android-tools-adb
```

---

## Connect to a Remote Android System

```bash
adb connect $HOSTNAME_OR_IP:$PORT
```

`$PORT` defaults to 5555.

---

## Check Connected Devices

```bash
adb devices
```

---

## Initiate Shell on Connected Device

```bash
adb shell
```

Once in the shell, attempt to escalate to `root` using `su`.

Example: [HTB Explore]().

---

## Install APK on Connected Device

```bash
adb install $PATH_TO_APK
```

---

## Configure Proxy

### View Proxy Settings

```bash
$ adb shell
(adb) settings list global | grep proxy
```

### Set Proxy

```bash
$ adb shell
(adb) settings put global http_proxy $FQDN_OR_IP:$PORT
```

### Clear Proxy

```bash
$ adb shell
(adb) settings delete global http_proxy
(adb) settings delete global global_http_proxy_host
(adb) settings delete global global_http_proxy_port
```
