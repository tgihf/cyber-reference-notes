# A Web Application's Behavior Based on File Extension & MIME Type

When you browse to a static file on a web server with a particular extension, the web server maps the extension to a [MIME type](https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/MIME_types/Common_types) and then maps the MIME type to a particular action.

For example, on an [[apache|Apache]] web server, its configuration file `/etc/apache2/apache2.conf` may contain the following directives:

```txt
LoadModule php_module /usr/lib/apache2/modules/libphp.so
AddType application/x-httpd-php .php
```

These map static files with the `.php` extension to the `application/x-httpd-php` MIME type which are mapped to be *executed* by Apache's PHP module. Arbitrary extensions could be specified.

---

## Directory-Specific Mappings - Apache

Apache has directory-specific configuration files named `.htaccess` that can also contain these mapping directives. For example, if `/var/www/html/foo/.htaccess` contained the following:

```txt
AddType application/x-httpd-php .blah
```

then browsing to any file with the extension `.blah` in `/var/www/html/foo/` would cause that file to be executed as PHP (i.e., `http://tgihf.click/foo/tgihf.blah`).

---

## Directory-Specific Mappings - IIS

IIS has similar directory-specific configuration files named `web.config`.

---

## References

[PortSwigger Web Security Academy](https://portswigger.net/web-security/file-upload)
