# Alternate Data Streams (ADSs)

> Alternate Data Streams (ADSs) are a file attribute only found on the NTFS file system. Every file has a `$DATA` attribute, also referred to as its primary data stream, which contains its data. A file can also contained alternate data streams, which can contain arbitrary data.

---

## Find All Files with Alternate Data Streams

- [[powershell#Find All Files with Alternate Data Streams]]

---

## Show a File's Alternate Data Streams

- [[dir#Show a File's Alternate Data Streams]]
- [[powershell#Show a File's Alternate Data Streams]]

---

## Read a File's Alternate Data Stream

```batch
type $FILE_PATH:$ADS_NAME
```

- [[powershell#Read a File's Alternate Data Stream]]

---

## Write to a File's Alternate Data Stream

```batch
echo "blah" > $FILE_PATH:$ADS_NAME
```

- [[powershell#Write to a File's Alternate Data Stream]]
