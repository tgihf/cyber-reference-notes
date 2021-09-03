# Regular Expressions in Go

---

## Determine Whether a String Matches Pattern

```go
import regexp

pattern = `\$(\d+\.\d{2})`  // Matches a dollar value with to decimal places
s = "$15.00"
doesMatch, err := regexp.MatchString(pattern, s)
if err != nil {
	// Handle error with regex pattern
}
if doesMatch {
	// The string matches the pattern
}
```

---

## Extract Group From Matched Regular Expression

```go
import regexp

s := "$15.00"
pattern := regexp.MustCompile(`\$(\d+\.\d{2})`)  // Matches a dollar value to two decimal places. Group 1 matches the actual float value itself without the dollar sign
matches := pattern.FindStringSubmatch(s)
if len(matches) > 0 {
	fmt.Println(matches[0])						// $15.00
	fmt.Println(matches[1])						// 15.00
}
```
