# Python3 HTTP Server that Redirects

## Source

```python
import sys
from http.server import HTTPServer, BaseHTTPRequestHandler

if len(sys.argv) < 3:
    print(f"Usage: {sys.argv[0]} <port_number> <url>")
    sys.exit()

class Redirect(BaseHTTPRequestHandler):
   def do_GET(self):
       self.send_response(302)
       self.send_header('Location', sys.argv[2])
       self.end_headers()

HTTPServer(("", int(sys.argv[1])), Redirect).serve_forever()
```

## Usage

```bash
python3 redirect.py $SERVE_PORT $URL_TO_REDIRECT_TO
```

---

## References

[StackOverflow](https://stackoverflow.com/questions/2506932/how-do-i-redirect-a-request-to-a-different-url-in-python)
