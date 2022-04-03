# XML External Entity (XXE) Injection

[[xml|XML]] External Entity (XXE) injection vulnerabilities arise when an application places unsanitized user input into an XML document and then parses it server-side. The attacker can exploit this vulnerability by injecting a malicious [[xml#External Entities|XML external entity]] into the XML document. When the server parses this document, the [[xml#External Entities|external entity]] will be evaluated, allowing the attacker to read server-local files or induce the server into making [[server-side-request-forgery|SSRF requests]].

---

## Types of XXE Attacks

1. [[xml-external-entity-injection#Reading Server-Local Files|Traditional XXE to read server-local file]]
2. [[xml-external-entity-injection#Performing SSRF Attacks|Traditional XXE to perform SSRF attack]]
3. [[xml-external-entity-injection#Out-of-Band Data Exfiltration|Blind XXE to exfiltrate data out-of-band to a system the attacker controls]]
4. [[xml-external-entity-injection#Error Message Data Exfiltration|Blind XXE to retrieve data via error messages]]

---

## Traditional XXE Attacks

These attacks assume that the some of the data from the processed XML parsing is rendered to the user. By injecting an [[xml#External Entities|XML external entity]] whose data is the contents of a resource at a URL, the attacker can trigger the server to read those contents and reflect them back to the user in the response.

### Reading Server-Local Files

To induce the server into reading `/etc/passwd`, assigning its contents to the `contents` entity, and then reflect them in the XML body:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE foo [ <!ENTITY contents SYSTEM "file:///etc/passwd"> ]>
<message>
	<banner>&contents;</banner>
</message>
```

### Performing SSRF Attacks

To induce the server into making a request to `http://tgihf.click/blah`, assigning its contents to the `contents` entity, and then reflect them in the XML body:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE foo [ <!ENTITY contents SYSTEM "http://tgihf.click/blah"> ]>
<message>
	<banner>&contents;</banner>
</message>
```

---

## Blind XXE Attacks

These attacks assume that the application is vulnerable to XXE injection, but it doesn't render any data from the processed XML document. However, there are still two general techniques can be leveraged to see output from the injection.

### Out-of-Band Data Exfiltration

In this technique, the target is vulnerable to XXE injection and the attacker can exploit the vulnerability to perform an [[xml-external-entity-injection#Performing SSRF Attacks|SSRF attack]], but the target doesn't render any data from the processed XML document. The attacker can host an external DTD that leverages XML parameter entities to read the contents of a file (i.e., `/etc/passwd`) and include them in the query parameter of an HTTP request to the attacker controlled server.

See [[xml#Parameter Entities External DTDs|here]] for an example.

Some things to note here: if the target file contains illegal URL characters (newlines, etc.), depending on the XML parser, this technique might not work. You can try to `CDATA` technique for that (see the [[xml-external-entity-injection#References|references]]).

### Error Message Data Exfiltration

In this technique, the target is vulnerable to XXE injection and it doesn't render any data from the processed XML document, but it does render error messages. The attacker can host an external DTD that leverages XML parameter entities to read the contents of a file (i.e., `/etc/passwd`) and construct a nonexistent local file path from those contents. The attacker can induce the XML parser into attempting to read this nonexistent file and when it fails, may render the outputs of the file in the error message.

See the "Exploiting blind XXE to retrieve data via error messages" section of PortSwigger Web Security Academy's Blind XML External Entity Injection article at [[xml-external-entity-injection#References|references]].

---

## References

[XML External Entities (XXE) Explained - PwnFunction - YouTube](https://www.youtube.com/watch?v=gjm6VHZa_8s)

[XML External Entity Injection - PortSwigger Web Security Academy](https://portswigger.net/web-security/xxe)

[Blind XML External Entity Injection - PortSwigger Web Security Academy](https://portswigger.net/web-security/xxe/blind)
