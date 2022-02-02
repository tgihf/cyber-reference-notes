# Craft the Phish

---

## Considerations for Bypassing Spam Filters

- Keep the phish simple
	- Avoid templates that have likely been sent by other people
- Don't copy the email template of a large organization
	- Someone has probably tried it before and it has been flagged as spam as a result
- Don't overtest
	- This could lead to your domain being blacklisted as a known spam source
- Avoid the temptation to have the target organization whitelist your phishing domain(s) in their spam filter
	- It may lead to a more successful campaign, but the organization may doubt the level of risk since the domains were whitelisted
- Ensure your mail service has verified your source domain so you pass [[dkim|DKIM]] checks (more on this while [[phishing-infrastructure|setting up the infrastructure]])

---

## Considerations for Timing the Phish

How you time your phish depends significantly on the target itself. Base the timing on your [[target-research-for-phishing#Target Familiarization|understanding of the target]], placing key emphasis on the target's timezone, work hours, and current events.

Many researchers avoid sending phishing emails during the work day as it increases the likelihood that all the employees will collectively see the email and dissuade each other from opening it.

Many have found success timing the phish *just after* most employees have made it home from the work day, as it avoids collective dissuading and takes advantage of the employee's desire to just be home for the day--they may quickly following the phishing link and provide the relevant credentials without much thought or investigation.

---

## References

[TCM Security - Practical Phishing Assessments](https://academy.tcm-sec.com/p/practical-phishing-assessments)
