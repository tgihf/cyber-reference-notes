# [Directory Traversal](https://portswigger.net/web-security/file-path-traversal)

> A web application vulnerability in which the application performs file system operations based on unsanitized file path input controlled by the user. Depending on the web application's functionality, this can allow an attacker to read arbitrary files on the web application server, from credential files to configuration files to SSH keys and more. It can also allow attackers to write arbitrary files on the server, which can lead to total server compromise.

---

## Directory Traversal Methodology

1. Profile the web application and note all inputs that appear to be used in file system operations
2. Attempt to traverse the file system using these inputs
	- If the target's technology stack includes an Apache Tomcat web server sitting behind an Nginx reverse proxy, see [[path-normalization#Path Normalization to Directory Traversal in Nginx Tomcat|here]]
3. Bypass any directory traversal defense mechanism
	- See [[directory-traversal#Directory Traversal Defense Mechanism Bypass Techniques|here]]
- Potential target files:
	- Linux:
		- Web application source code and configuration files
		- SSH keys
		- [[proc-filesystem|proc filesystem]]

---

## Directory Traversal Defense Mechanism Bypass Techniques

### Try the absolute path to the file

For example, instead of `../../../etc/passwd`, try `/etc/passwd`.

This is effective when the application treats the supplied input as a relative path (i.e., `blah.png` instead of `/var/www/images/blah.png`).

Example: [PortSwigger Web Security Academy Directory Traversal Lab - File path traversal, traversal sequences blocked with absolute path bypass](https://github.com/tgihf/writeups/blob/master/port-swigger-web-academy/directory-traversal/02%20-%20File%20path%20traversal%2C%20traversal%20sequences%20blocked%20with%20absolute%20path%20bypass.md).

### Embed traversal sequences within each other

For example, instead of `../../../etc/passwd`, try `....//....//....//etc/passwd`.

This is effective when the application strips away traversal sequences, but doesn't do it recursively (i.e., `filename.replace("../", "")`). When the inner traversal sequences are stripped away, the outer remain.

Example: [PortSwigger Web Security Academy Directory Traversal Lab - File path traversal, traversal sequences stripped non-recursively.md](https://github.com/tgihf/writeups/blob/master/port-swigger-web-academy/directory-traversal/03%20-%20File%20path%20traversal%2C%20traversal%20sequences%20stripped%20non-recursively.md).

### Use non-standard encodings for the traversal sequences

For example, instead of `../../../etc/passwd`, you might use `..%252f..%252f..%252fetc/passwd` if the application performs extraneous URl-decoding.

The key here is to try to understand what kind of serialization is happening to the input string on the backend. Don't just throw things at the target. Be methodical.

Example: [PortSwigger Web Security Academy Directory Traversal Lab - File path traversal, traversal sequences stripped with superfluous URL-decode](https://github.com/tgihf/writeups/blob/master/port-swigger-web-academy/directory-traversal/04%20-%20File%20path%20traversal%2C%20traversal%20sequences%20stripped%20with%20superfluous%20URL-decode.md).

### Use an absolute path that also traverses the file system

For example, instead of `/../../../etc/passwd`, try `/var/www/images/../../../etc/passwd`.

This is effective if the application requires an absolute path to the input file but also validates that the path begins with a certain sub-path (in this example, `/var/www/images`).

Example: [PortSwigger Web Security Academy Directory Traversal Lab - File path traversal, validation of start of path](https://github.com/tgihf/writeups/blob/master/port-swigger-web-academy/directory-traversal/05%20-%20File%20path%20traversal%2C%20validation%20of%20start%20of%20path.md).

### Use a null byte (`%00`) to bypass extension whitelisting

If the application requires the input to have a particular extension, you can potentially use a URL-encoded null byte character (`%00`) in the file name just before the extension to have the input satisfy the extension whitelisting but cause the file system operation to ignore the extension.

For example, if the application requires the `filename` parameter to have the extension `.jpg`, you could use the following to bypass that extension and read `/etc/passwd`: `../../../etc/passwd%00.jpg`.

Example: [PortSwigger Web Security Academy Directory Traversal Lab - File path traversal, validation of file extension with null byte bypass](https://github.com/tgihf/writeups/blob/master/port-swigger-web-academy/directory-traversal/06%20-%20File%20path%20traversal%2C%20validation%20of%20file%20extension%20with%20null%20byte%20bypass.md).

---

## Directory Traversal Example

Let's say a web application has a page named `/load-image.php` whose purpose is to render various images that reside in the server's `/var/www/images` directory. The page uses the query parameter `file`, like so:

```txt
https://blah.blah/load-image.php?file=cat.png
```

The backend reads the value from `file`, the string `cat.png`, and prepends `/var/www/images/` to create the full file path. Then it renders the contents of the file to the user in an HTML `img` tag, like so:

```php
# load-image.php
<?php
	$path = "/var/www/images/" . $_GET["file"];
	$contents = file_get_contents($path);
	echo "<img src='data:image/png;base64, " . base64_encode($contents) . "'>";
?>
```

The backend doesn't provide any sort of input validation on `file` to ensure it is formatted propery. Since the file system API is used to retrieve the contents of the file (`file_get_contents()`), a `file` value of `../../../etc/passwd` is valid input. This input would cause the contents of `/etc/passwd` to be base64-encoded and output in the `img` tag to the attacker. The attacker would simply have to base64-decode the string to read the file.

See a more detailed example at [PortSwigger Web Security Academy Directory Traversal Lab - File path traversal, simple case](https://github.com/tgihf/writeups/blob/master/port-swigger-web-academy/directory-traversal/01%20-%20File%20path%20traversal%2C%20simple%20case.md).

---

## Directory Traversal Mitigation

### 1. Don't pass user input to file system operations

### 2. If you can't do #1, validate user input

It is best to validate user input against a whitelist of permitted values.

If you can't do that, validate user input against a solid regular expression.

If you can't do either of those, at least verify that user input contains only permitted content, such as purely alphanumeric characters.

### 3. Append the user input to the base directory

### 4. Use a platform-specific file system API to canonicalize the path
