# Email Address Research

> Scour open sources for a target individual's or organization's email addresses.

---

## Email Address Research Process

1. Given the target domain(s), aggregate a list of potential email addresses using [[email-address-research#Find a Domain's Email Addresses|these tools]].
2. Verify the aggregated email addresses using [[email-address-research#Verify an Email Address|these tools]].
3. **Optional:** If you want to generate a list of potential email addresses:
	- Analyze the verified, aggregated email addresses to determine the **email address pattern(s)**
	- [[email-address-generation|Generate email addresses]] using the determined **email address pattern(s)**

---

## Find a Domain's Email Addresses

### Command Line Tools

- [[h8mail]]
- [[theHarvester#Enumerate SOURCE for DOMAIN 's Information|theHarvester]]

### Web Applications

#### `hunter.io`

[hunter.io](https://hunter.io/) is a web application that takes a domain name and scours the Internet for all email addresses on that domain.

It categorizes the email addresses it finds (i.e., `Sales`, `Human Resources`, `Engineering`), allowing you to filter for a particular type of employee.

It also determines the most common naming pattern based on the email addresses it finds (i.e., `{f}{last}@domain.com`).

![[Pasted image 20220125200948.png]]

A free account can make 25 searches per month.

![[Pasted image 20220125203302.png]]

#### `phonebook.cz`

[phonebook](https://phonebook.cz/) is a web application that takes a domain name and scours 34 billion records for all subdomains, **email addresses**, or URLs related to the domain name. No account required.

![[Pasted image 20220125202052.png]]

#### `Clearbit Connect`

[Clearbit Connect](https://connect.clearbit.com/) is a Chrome extension that takes a domain name and  scours the Internet for all email addresses related to the domain name. A free account can list 100 email addresses per month.

Alongside each email address, it often also lists a link to where it found the email address. This can be helpful for gathering more information on a particular individual in order to spearphish them.

It also allows you to filter email addresses based on roles and seniority.

---

## Verify an Email Address

Once you have a potential email address(es) in hand, you can pass it to one of these tools for verification of its legitimacy.

### [Email Hippo's Email Address Verifier](https://tools.emailhippo.com/)

![[Pasted image 20220125203917.png]]

### [Email-Checker.net](https://email-checker.net/validate)

![[Pasted image 20220125204252.png]]
