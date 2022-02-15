# File Uploads

> A common web application feature is to allow users to upload files. However, the web application has to properly filter uploaded files to ensure they are of the proper name, type, content, and size. When they don't, an attacker can upload files that allow remote code execution, replace critical system files, or even fill the server's disk space.

---

## File Upload Exploitation Methodology

### 1. Understand the application's technology stack

Frontend to backend. This will help you understand exactly how the application may be processing the uploaded file and how you can exploit its behavior to achieve your objective.

### 2. Understand the backend server's file upload filtering process

#### Does it implement any kind of filtering?

If not, upload whatever you want to achieve your objective!

If so, proceed.

#### What is its filtering process?

- Does it filter on the file's `Content-Type` header? See [[file-uploads#Content-Type Filtering|here]].
- Does it filter on the file's `filename` extension? See [[file-uploads#Filename Extension Filtering|here]].
- Does it filter on the file's content? See [[file-uploads#File Content Filtering|here]].

### 3. (Depending on your Objective) Navigating to the Uploaded File

Depending on your objective, it may be necessary to navigate to the file after uploading it (i.e., to execute a webshell).

- What's the web application's strategy for storing the uploaded file?
	- What directory does it store them in?
	- Does it retain the input `filename`?
	- Does it rename it to a randomly generated file name?
- In the case of a webshell, are you able to navigate to the file but it doesn't execute? Instead it either returns the contents of the file or perhaps nothing at all? Perhaps the application refuses to execute anything from the default file-upload directory (i.e., `/uploads`). Many applications use the file's `filename` attribute in its `Content-Disposition` to determine what to name the file. Can you leverage this attribute to write the file to another directory and effectively bypass the execution restriction? This is a form of [[directory-traversal|directory traversal]], so be sure to consider [[directory-traversal#3 Bypass any directory traversal defense mechanism|bypassing any defense mechanisms]].

### 4. (Depending on your Objective) Uploading Malicious Client-Side Scripts

Are you able to overwrite a client-side script that is included in the web application? If so, you may be able to write an XSS payload.

### 5. (Depending on your Objective) Exploiting Vulnerabilities in the Parsing of Uploaded Files

Perhaps the web application's technology stack or excellent filtering techniques prevent you from uploading and executing a web shell. What does the web application do with the file once you've uploaded it?

Does the server parse XML files? You may be able to exploit an [[xxe|XXE]] vulnerability in the parsing library.

---

## `Content-Type` Filtering

When you upload a file via HTTP, you tend to do so via an HTTP request whose overall `Content-Type` is `multipart/form-data`.

Each element within the form contains its own `Content-Disposition` section, which contains data about the element.

In a typical, non-file form element, the only field in the `Content-Disposition` section is `name`, which is the name of the element in the HTML form (i.e., `name="username"`).

In a file form element, there are typically three fields:

- `name`: the name of the element in the HTML form
- `filename`: the name of the file
- `Content-Type`: the [MIME type](https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/MIME_types/Common_types) of the file

It is possible for a web application to reject file uploaded attempts based on the MIME type in the file element's `Content-Type` field.

- [ ] Use an intercepting proxy like BurpSuite to fiddle with this field, changing it to a MIME type that the application wants (i.e., `image/jpeg` or `image/png`) and see how the application responds.

---

## `Filename` Extension Filtering

Many web applications filter uploaded files based on the extension of the file specified in the file's `Content-Disposition`'s `filename` value. This filtering isn't always perfect and there are several known bypass techniques.

While testing these techniques, try to determine exactly what type of extension filtering the application is doing. More specifically:

- Is your preferred extension **blacklisted**?
- Or are only certain extensions **whitelisted**?

### Bypass Techniques

#### Extension Obfuscation Bypass

- [ ] Try lesser known file extensions that are valid alternatives to the target one.
	- i.e., instead of `.php`, you could try `.php4`, `.php5`, `.phtml`
		- Possible extensions can be found [here](https://github.com/swisskyrepo/PayloadsAllTheThings/tree/master/Upload%20Insecure%20Files)
- [ ] Try to alter the extension's case.
	- i.e., instead of `.php`, you could try `.pHp` or `.PHp`.
- [ ] Try combining multiple extensions.
	- i.e., if `.png` is allowed but you want `.php`, try `.php.png` or `.png.php`. Depending on the application's blacklisting logic, it could work. See [[extension-filtering-bypass-multiple-extensions|here]] for an example.
- [ ] Try adding trailing characters like whitespace or dots.
	- i.e., instead of `.php`, you could try `.php.`.
- [ ] Try URL- or double URL-encoding dots, forward slashes, and backward slashes. Depending on where the blacklisting logic occurs in the stack, it is possible that it could receive and allow the URL-encoded filename which is later URL-decoded before being processed.
	- i.e., instead of `tgihf.php`, you could try `tgihf%2E.php`
- [ ] Try adding a semicolon or a URL-encoded NULL byte (`%00`) before the file extension. If the file extension is validated in a high-level language like PHP or Java but processed in a low-level language like C or C++, this could work.
	- i.e., if `.png` is allowed but you want `.php`, instead of `tgihf.php`, you could try `tgihf.php%00.png` or `tgihf.php;.png`.
-  [ ] Some blacklisting programs work by replacing the offending extension with an empty string (`""`). Ideally, this should be done recursively. It isn't always. Try an extension that would defeat a non-recursive extension replacer.
	- i.e., if `.php` is replaced non-recursively, you could try `tgihf.p.phphp`

Other ideas [here](https://github.com/swisskyrepo/PayloadsAllTheThings/tree/master/Upload%20Insecure%20Files).

#### Extension-to-MIME-to-Execution Module Configuration Overwrite Bypass

- [ ] Via the file upload, can you overwrite the directory-specific configuration file that maps extensions to MIME types to execution modules? Perhaps you can map an arbitrary file extension that's not on the extension blacklist to the target execution module (i.e., `php`) and upload a file with that extension. See [[extension-mime-behavior|here]] for more information and examples based on particular web servers.

---

## File Content Filtering

Filtering based on a file's content is significantly more secure than based on its `Content-Type` or `filename` extension, but also significantly more complicated.

How does the application determine a file's type based on its contents? Here's some techniques and corresponding bypasses.

### Magic Bytes Bypassing

Some file types have "magic bytes:" byte values in their header and/or footer that are always the same. These can generally be used to uniquely identify a file type.

#### Adding the Magic Bytes

- [ ] Can you just add the magic bytes to the file without corrupting it?

#### Creating a Polyglot File

If the application checks the file's magic bytes to ensure they are the same as the target file type, perhaps you can embed your payload within the target file type?

- [ ] Using [[exiftool#Embed a Payload within an Image's Metadata|exiftool]], it's possible to create a polyglot JPEG file containing a malicious payload within its metadata. When uploaded with the proper extension and browsed to, the web application may execute the malicious payload.

More information [here](https://medium.com/swlh/polyglot-files-a-hackers-best-friend-850bf812dd8a).

---

## References

[PortSwigger Web Security Academy](https://portswigger.net/web-security/file-upload)

[Payloads All the Things - Upload Insecure Files](https://github.com/swisskyrepo/PayloadsAllTheThings/tree/master/Upload%20Insecure%20Files)

[HackTricks - File Uploads](https://book.hacktricks.xyz/pentesting-web/file-upload)
