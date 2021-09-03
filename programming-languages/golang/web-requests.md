# Making Web Requests in Go

---

## GET Request to URL & Convert Response Body to String

```go
import (
	"io/ioutil"
	"net/http"
)

resp, err := http.Get("https://tgihf.click")
if err != nil {
	// Handle error of not being able to connect to server
}
bodyBytes, err := ioutil.ReadAll(resp.Body)
if err != nil {
	// Handle error of not being able to read the body
}
body := string(bodyBytes)
```

---

## POST Request to URL with URL-Encoded Body & Convert Response Body to String

```go
import (
	"io/ioutil"
	"net/http"
	"net/url"
)

requestBody := url.Values{"username": {"tgihf"}, "password": {"blah"}}
resp, err := http.Post(
	"https://tgihf.click",						// URL
	"application/x-www-form-urlencoded",		// Content type
	strings.NewReader(requestBody.Encode()),	// Body
)
if err != nil {
	// Handle error of not being able to connect to server
}
bodyBytes, err := ioutil.ReadAll(resp.Body)
if err != nil {
	// Handle error of not being able to read the body
}
body := string(bodyBytes)
```

---

## HTTP Request Through Proxy

```go
import (
	"crypto/tls"
	"io/ioutil"
	"net/http"
	"net/url"
)

requestBody := url.Values{"username": {"tgihf"}, "password": {"blah"}}
proxyUrl, _ := url.Parse("http://127.0.0.1:8080")
client := http.Client{
	Transport: &http.Transport{
		Proxy:               http.ProxyURL(proxyUrl),
		TLSClientConfig:     &tls.Config{InsecureSkipVerify: true},	// Ignore self-signed certificate error
	},
}
req, err := http.NewRequest(
	"POST",										// Method
	"https://tgihf.click",						// URL
	strings.NewReader(requestBody.Encode())		// Body
)
if err != nil {
	// Handle error with building request
}
resp, err := client.Do(req)
if err != nil {
	// handle error of not being able to send the request
}
bodyBytes, err := ioutil.ReadAll(resp.Body)
if err != nil {
	// Handle error of not being able to read the body
}
body := string(bodyBytes)
```

---

## HTTP Request with Cookie

```go
import (
	"io/ioutil"
	"net/http"
)

client := http.Client{}
req, err := http.NewRequest(
	"GET",										// Method
	"https://tgihf.click",						// URL
	nil											// Body
)
if err != nil {
	// Handle error with building request
}
req.AddCookie(&http.Cookie{Name: "session", Value: "ab8d64m3hd9gkcb27dlm6d8a6d937s18"})
resp, err := client.Do(req)
if err != nil {
	// handle error of not being able to send the request
}
bodyBytes, err := ioutil.ReadAll(resp.Body)
if err != nil {
	// Handle error of not being able to read the body
}
body := string(bodyBytes)
```

---

## HTTP Request That Doesn't Follow Redirects

```go
import (
	"io/ioutil"
	"net/http"
)

client := http.Client{
	CheckRedirect: func(req *http.Request, via []*http.Request) error {
		return http.ErrUseLastResponse
	},
}
req, err := http.NewRequest(
	"GET",										// Method
	"https://tgihf.click",						// URL
	nil											// Body
)
if err != nil {
	// Handle error with building request
}
resp, err := client.Do(req)
if err != nil {
	// handle error of not being able to send the request
}
bodyBytes, err := ioutil.ReadAll(resp.Body)
if err != nil {
	// Handle error of not being able to read the body
}
body := string(bodyBytes)
```

---

## HTTP Request With Increased Timeout

```go
import (
	"io/ioutil"
	"net/http"
)

client := http.Client{Timeout: 60 * time.Second}
req, err := http.NewRequest(
	"GET",										// Method
	"https://tgihf.click",						// URL
	nil											// Body
)
if err != nil {
	// Handle error with building request
}
resp, err := client.Do(req)
if err != nil {
	// handle error of not being able to send the request
}
bodyBytes, err := ioutil.ReadAll(resp.Body)
if err != nil {
	// Handle error of not being able to read the body
}
body := string(bodyBytes)
```

---

## HTTP Request with Increased TLS Handshake Timeout

```go
client := http.Client{
	Transport: &http.Transport{
		TLSHandshakeTimeout: 60 * time.Second,
	}
}
req, err := http.NewRequest(
	"GET",										// Method
	"https://tgihf.click",						// URL
	nil											// Body
)
if err != nil {
	// Handle error with building request
}
resp, err := client.Do(req)
if err != nil {
	// handle error of not being able to send the request
}
bodyBytes, err := ioutil.ReadAll(resp.Body)
if err != nil {
	// Handle error of not being able to read the body
}
body := string(bodyBytes)
```