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

## PHP

File inclusion vulnerabilities arise in web applications written in PHP when the application passes un- or improperly-santized user input into PHP's [include()](https://www.php.net/manual/en/function.include.php), [include_once()](https://www.php.net/manual/en/function.include-once.php), [require()](https://www.php.net/manual/en/function.require.php), and [require_once()](https://www.php.net/manual/en/function.require-once.php) functions.

If the input file path is absolute or relative to the current directory, these functions will "include" that file. If the input file path isn't absolute or relative to the current directory, these functions will search in the directories specified in the `include_path` variable (specified in `php.ini`), then in the calling script's directory, then in the current working directory. If `require()` or `require_once()` don't find the file, they will throw an error. If `include()` or `include_once()` don't find the file, they will emit a warning.

If these functions find the input file, they will "include" it. This means they will drop out of PHP parsing mode and enter into HTML parsing mode and begin reading the file. All text outside of PHP tags will be rendered as HTML. All text inside PHP tags will be executed as PHP code.

### Remote File Inclusion

For a PHP web application to be vulnerable to remote file inclusion, its `php.ini` file must have `allow_url_fopen` and `allow_url_include` set to `On`. By default, both of these are set to `Off`.

### Executing PHP Code

If you find a file inclusion vulnerability and give it the path of a PHP source code file, it will execute that code.

### Reading Arbitrary Files

If you find a file inclusion vulnerability and give it the path of a non-PHP source code file, it will render that file (assuming the user running the PHP process has permissions to access the file).

### Reading PHP Source Code Files

`include()`, `include_once()`, `require()`, and `require_once()` will also take [PHP  Wrappers](https://www.php.net/manual/en/wrappers.php.php), which are a PHP mechanism for interacting with various input streams. PHP's `php://filter` wrapper can be used to read in a resource (file), apply a [filter](https://www.php.net/manual/en/filters.php) to its contents, and return the filtered out.

There are several notable types of these filters: string filters, conversion filters, compression filters, and encryption filters. The [conversion filters](https://www.php.net/manual/en/filters.convert.php) can be used to base64 encode the input stream.

To read a PHP source code file, input the PHP wrapper `php://filter/convert.base64-encode/resource=$FILE_PATH`. This will return the base64-encoded PHP source code. Base64-decode it offline and read the source.

---

## References

[File inclusion vulnerability - Wikipedia](https://en.wikipedia.org/wiki/File_inclusion_vulnerability)
