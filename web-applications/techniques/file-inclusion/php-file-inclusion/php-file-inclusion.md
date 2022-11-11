# PHP File Inclusion

File inclusion vulnerabilities arise in web applications written in PHP when the application passes un- or improperly-santized user input into PHP's [include()](https://www.php.net/manual/en/function.include.php), [include_once()](https://www.php.net/manual/en/function.include-once.php), [require()](https://www.php.net/manual/en/function.require.php), and [require_once()](https://www.php.net/manual/en/function.require-once.php) functions.

If the input file path is absolute or relative to the current directory, these functions will "include" that file. If the input file path isn't absolute or relative to the current directory, these functions will search in the directories specified in the `include_path` variable (specified in `php.ini`), then in the calling script's directory, then in the current working directory. If `require()` or `require_once()` don't find the file, they will throw an error. If `include()` or `include_once()` don't find the file, they will emit a warning.

If these functions find the input file, they will "include" it. This means they will drop out of PHP parsing mode and enter into HTML parsing mode and begin reading the file. All text outside of PHP tags will be rendered as HTML. All text inside PHP tags will be executed as PHP code.

---

## Remote File Inclusion

For a PHP web application to be vulnerable to remote file inclusion, its `php.ini` file must have `allow_url_fopen` and `allow_url_include` set to `On`. By default, both of these are set to `Off`.

---

## LFI Technique 01: Executing PHP Code

If you find a file inclusion vulnerability and give it the path of a PHP source code file, it will execute that code.

---

## LFI Technique 02: Reading Arbitrary Files

If you find a file inclusion vulnerability and give it the path of a non-PHP source code file, it will render that file (assuming the user running the PHP process has permissions to access the file).

---

## LFI Technique 03: Reading PHP Source Code Files

`include()`, `include_once()`, `require()`, and `require_once()` will also take [PHP  Wrappers](https://www.php.net/manual/en/wrappers.php.php), which are a PHP mechanism for interacting with various input streams. PHP's `php://filter` wrapper can be used to read in a resource (file), apply a [filter](https://www.php.net/manual/en/filters.php) to its contents, and return the filtered output.

There are several notable types of these filters: string filters, conversion filters, compression filters, and encryption filters. The [conversion filters](https://www.php.net/manual/en/filters.convert.php) can be used to base64 encode the input stream.

To read a PHP source code file, input the PHP wrapper `php://filter/convert.base64-encode/resource=$FILE_PATH`. This will return the base64-encoded PHP source code. Base64-decode it offline and read the source.

More on this [here](https://book.hacktricks.xyz/pentesting-web/file-inclusion#lfi-rfi-using-php-wrappers).

---

## LFI Technique 04: RCE via Log Poisoning

Can you include the web server log file(s)? Does anything in the logs appear to be injectable (query parameters, headers, etc.)? You can inject PHP into those elements in the request and then include the log file, executing the PHP.

Newer versions of Apache and PHP prevent the inclusion of log files by default.

---

## LFI Technique 05: RCE with PHP + Nginx

See [[php-lfi-with-nginx|here]].

---

## LFI Technique 06: RCE via `PHP_SESSION_UPLOAD_PROGRESS`

See [[php-lfi-and-session-upload-progress-technique|here]].

---

## LFI Technique 07: RCE via Temporary File Upoad with `compress.zlib://`

TODO

---

## LFI Technique 08: RCE on Windows via `FindFirstFile()`

TODO

---

## LFI Technique 09: RCE with `phpinfo()` Assistance

TODO

---

## Protection Mechanisms

PHP has various configuration settings that can be leveraged by application developers to mitigate file inclusion vulnerabilities.

- `open_basedir`: A string of colon-separated directories that files can be "included" from
	- i.e., if `open_basedir` == `/www:/tmp`, then only files in `/www` and `/tmp` can be "included" (this includes files in subdirectories of those directories as well)

---

## References

[Bier Baumer - PHP LFI with Nginx Assistance](https://bierbaumer.net/security/php-lfi-with-nginx-assistance/)
