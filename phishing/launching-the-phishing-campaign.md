# Setting Up & Launching the Phishing Campaign

---

## Campaign Setup Process

All of these steps are done in [[gophish|GoPhish]].

1. Create a new group with the [[email-address-research|target email addresses]]
	- `Users & Groups` -> `+ New Group`
	- Make sure that if you are impersonating a particular user, their name isn't included
2. Create the email template using the [[craft-the-phish|crafted phish]]
	- `Email Templates`
	- Include the URL generated during the final step of [[phishing-infrastructure|infrastructure setup]]
3. [[gophish|GoPhish]] requires you to specify a landing page, so go ahead and create a blank one
	- `Landing Pages`
4. Create a [[gophish#Creating a Sending Profile|sending profile]]
	- `Sending Profiles`
5. Create a new campaign including everything you configured in steps 1-4
	- `Campaigns` -> `+ New Campaign`
		- The landing page doesn't matter if you're using [[evilginx2]]
		- The URL should be `https://$PUBLIC_IP`, where `$PUBLIC_IP` is the public IP address of your phishing server
6. Schedule & launch the campaign

	