# Extension Filtering of Web Application File Uploads

Many web applications filter file uploads based off the file extension.

For example, Facebook might only allow you to upload image files for your profile picture, so they employ a filter that whitelists extensions like .jpeg, .jpg, .png, etc. and blacklists all others. Thus, this won't work:

```bash
evil.php
```

How could you bypass this kind of a filter to upload a PHP webshell?

Well, it all depends on how the backend server checks the file extension. Many perform the following operation:

```python
if filename.split('.')[1] not in ['jpeg', 'jpg', 'png']:
    reject()
```

That is, they only check the string immediately following the *first* dot (.). You can bypass this type of filter by adding *.php* as a second extension to the file and then uploading it.

```bash
evil.jpeg.php
```
