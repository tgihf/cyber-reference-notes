# File Inclusion

> Somewhat related to [[directory-traversal|directory traversal vulnerabilities]], file inclusion vulnerabilities are a type of web application vulnerability that is most commonly found to affect web applications that rely on a scripting runtime (i.e., PHP, JSP). The vulnerability arises when an application builds a path to executable code using an attacker-controlled variable in a way that allows the attacker to control which file is executed at runtime.

---

## Remote File Inclusion

Remote file inclusion occurs when a web application's scripting runtime (i.e., PHP, JSP) loads and executes a script from a URL that is defined and controlled by an attacker (i.e., `https://foo.bar/blah.php`)

---

## Local File Inclusion

Local file inclusion occurs when a web application's scripting runtime (i.e., PHP, JSP) loads and executes a script from a local file path (local to the web application) that is defined by an attacker (i.e., `/etc/passwd`).

Local file inclusion is significantly more common than remote file inclusion.

---

## File Inclusion Techniques by Language

- [[php-file-inclusion|PHP]]

---

## References

[File inclusion vulnerability - Wikipedia](https://en.wikipedia.org/wiki/File_inclusion_vulnerability)
