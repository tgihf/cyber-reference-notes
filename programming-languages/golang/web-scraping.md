# Scraping the Web with Go

---

## Install [Soup for Go](https://github.com/anaskhan96/soup)

```bash
go get github.com/anaskhan96/soup
```

---

## Extract Single `div` With `id` == `tgihf`

`body` is a string of the HTML response body. To convert an `http.Response.Body` into a string, see [[web-requests#GET Request to URL Convert Response Body to String|here]].

```go
import "github.com/anaskhan96/soup"

body := `
<html>
	<div id="tgihf">
		blah
	</div>
</html>
`
html := soup.HTMLParse(body)
div := html.Find(
	"div",			// tag type
	"id",			// attribute name -- optional
	"tgihf",		// attribute value -- optional
)
fmt.Println(div.Text())		// The text value within the div tags
fmt.Println(div.Attrs())	// A map[string]string of all of the tag's attribute values
```

---

## Extract Nested Element

```go
import "github.com/anaskhan96/soup"

body := `
<html>
	<table>
		<tr>
			<th>Username</th>
			<th>Password</th>
		</tr>
		<tr>
			<td>tgihf</td>
			<td>blah</td>
		</tr>
	</table>
</html>
`
html := soup.HTMLParse(body)
trs := html.Find("table").FindAll("tr")
for _, tr := range trs {
	tds := tr.FindAll("td")
	if len(tds) == 2 {	// If there are actually td elements within the tr:
		fmt.Printf("[*] Username: %s, Password: %s", tds[0].Text(), tds[1].Text())
	}
}
```