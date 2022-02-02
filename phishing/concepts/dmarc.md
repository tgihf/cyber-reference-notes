# [Domain-based Message Authentication, Reporting, & Conformance](https://support.dnsimple.com/articles/dmarc-record/)

The **DMARC** protocol attempts to resolve the age-old problem of email spoofing (when someone sends an email from a domain they don't actually have access to).

It does this by performing [[spf|SPF]] and [[dkim|DKIM]] checks on all emails it receives. If either of those protocols returns the same domain as the source domain or a subdomain of it, the DMARC check "passes."

DMARC isn't a silver bullet for email security, but from a phisher's perspective, it's important to ensure that your source domain will pass a DMARC check.
