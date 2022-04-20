## File Upload with `requests`

```python
import io
import requests


url = "http://10.129.126.116/activate.php"
part_name = "datafile"
file_name = "file.txt"
content_type = "text/plain"

requests.post(
	url,
	files={part_name: (file_name, io.StringIO("foobar"), content_type)}
)
```

```http
POST /activate_license.php HTTP/1.1
Host: 10.129.126.116
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101 Firefox/78.0
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
Accept-Language: en-US,en;q=0.5
Accept-Encoding: gzip, deflate
Content-Type: multipart/form-data; boundary=---------------------------130002762133667838183806255606
Content-Length: 235
Origin: http://10.129.126.116
Connection: close
Referer: http://10.129.126.116/beta.html
Upgrade-Insecure-Requests: 1

-----------------------------130002762133667838183806255606
Content-Disposition: form-data; name="datafile"; filename="file.txt"
Content-Type: text/plain

foobar
-----------------------------130002762133667838183806255606--
```

---

### References

[StackOverflow](https://stackoverflow.com/questions/43938742/python-requests-upload-file)
