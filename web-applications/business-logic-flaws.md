# [Business Logic Flaws](https://portswigger.net/web-security/logic-flaws)

> A business logic flaw in an application is a vulnerability that exists due to the developers making bad assumptions about user behavior. Business logic flaws result in the application entering a state that the developers did not originally anticipate. Business logic flaws are typically very contextual, though these vulnerabilities can arise based on common logical flaws that developers make.

---

## Exploiting Logic Flaws

The key to exploiting logic flaws is to methodically analyze an application's features and inputs to compare its **expected** behavior with its **actual** behavior.

For each feature (login, shopping cart, comment submission, etc.), think about how that feature should be implemented securely and systematically probe it to determine if it is actually implemented that way. If its behavior diverges from your expected secure implementation, determine if that divergence is a vulnerability.

---

## [Common Logic Flaws](https://portswigger.net/web-security/logic-flaws/examples)

### [Excessive Trust in Client-Side Controls](https://portswigger.net/web-security/logic-flaws/examples#excessive-trust-in-client-side-controls)

Client-side input sanitization is great at directing normal users on how to properly use the application. However, it is completely useless at preventing a malicious user from supplying devious input. Bypass client-side controls by changing the HTML, redefining key JavaScript functions, or using an intercepting proxy like BurpSuite.

It is critical that application developers scrutinize input on the server side.

Two examples:
1. [PortSwigger Web Security Academy Business Logic Flaws Lab - Excessive trust in client-side controls](https://github.com/tgihf/writeups/blob/master/port-swigger-web-academy/business-logic-flaws/01%20-%20Excessive%20trust%20in%20client-side%20controls.md)
2. [PortSwigger Web Security Academy Authentication Lab - 2FA broken logic](https://github.com/tgihf/writeups/blob/master/port-swigger-web-academy/authentication/multi-factor-authentication/08%20-%202FA%20broken%20logic.md)

---

### [Failing to Handle Unconvential Input](https://portswigger.net/web-security/logic-flaws/examples#failing-to-handle-unconventional-input)

A web application may accept arbitrary data for a particular parameter, but it is the implemented business logic that determines whether that value is legitimate or not and how to handle it either way.

For example, consider the transfer funds functionality of a banking application. You have several parameters: `sender`, `receiver`, `funds`, and maybe more. `funds` should always be equal to or greater than 0, right? Else, a malicious `sender` may be able to "send" negative `funds` to a `receiver` and thus, steal money from them!

Application developers have to consider carefully what are the acceptable types and values ranges of all input values.

When testing an application, consider inputs in ranges that regular users are unlikely to ever enter--these are the ranges that developers may have never implemented logic to deal with properly. Try:

- Exceptionally high or lower numeric values
- Blank or abnormally long strings

When evaluating the reponses, consider the following questions:

- Are there any limits that are imposed on the data?
- What happens when you reach those limits?
- Is any transformation or normalization being performed on the input?

Examples:
- [PortSwigger Web Security Academy Business Logic Flaws Lab - High-level logic vulnerability](https://github.com/tgihf/writeups/blob/master/port-swigger-web-academy/business-logic-flaws/02%20-%20High-level%20logic%20vulnerability.md)
- [PortSwigger Web Security Academy Business Logic Flaws Lab - Low-level logic vulnerability](https://github.com/tgihf/writeups/blob/master/port-swigger-web-academy/business-logic-flaws/03%20-%20Low-level%20logic%20flaw.md)
- [PortSwigger Web Security Academy Business Logic Flaws Lab - Inconsistent handling of exceptional input](https://github.com/tgihf/writeups/blob/master/port-swigger-web-academy/business-logic-flaws/04%20-%20Inconsistent%20handling%20of%20exceptional%20input.md)

---

### [Trusting but not verifying](https://portswigger.net/web-security/logic-flaws/examples#making-flawed-assumptions-about-user-behavior)

Authenticated users are typically trusted to perform particular actions. However, every request a user makes should be scrutinized to ensure that user is authorized to make that request.

Authorization rules should be applied consistently throughout an application, even after the user has gone through the process or proving their trustworthiness. Authorization tokens should be checked with every request and should expire at some appropriate time.

To probe for this kind of logic flaw:
- After a successful authentication, attempt to execute actions that a user account at your privilege level shouldn't be able to execute

Example: Just because a user has proven they have access to the email address they used to create their account doesn't mean an application should allow them to change their email address without verification. See for a practical example: [PortSwigger Web Security Academy Business Logic Flaws Lab - Inconsistent Security Controls](https://github.com/tgihf/writeups/blob/master/port-swigger-web-academy/business-logic-flaws/05%20-%20Inconsistent%20security%20controls.md).

---

### [Assuming users will supply manadatory input](https://portswigger.net/web-security/logic-flaws/examples#making-flawed-assumptions-about-user-behavior)

It's too easy for an attacker to intercept a request and delete the "mandatory" inputs. Based on the application, submitting blank a parameter value or removing the parameter entirely can cause unexpected behavior. This is especially true for applications that use the same endpoint for multiple purposes and rely on parameter values to determine the code path to be taken. In this case, omitting parameters can allow an attacker to traverse unintended code paths.

To probe for this kind of logic flaw, try:

- For each parameter, one at a time:
	- Submit a blank value
	- Remove the parameter entirely

Analyze each response to determine whether a vulnerability is present.

Example: [PortSwigger Web Security Academy Business Logic Flaws Lab - Weak isolation on dual-use endpoint](https://github.com/tgihf/writeups/blob/master/port-swigger-web-academy/business-logic-flaws/06%20-%20Weak%20isolation%20on%20dual-use%20endpoint.md)

---

### [Assuming users will follow the intended sequence](https://portswigger.net/web-security/logic-flaws/examples#making-flawed-assumptions-about-user-behavior)

Web applications guide the user through the sequence of behavior the application expects via the front end interface. However, attackers can use intercepting proxies to replay and tamper these requests at will, outside of the intended sequence.

If a web application expects a user to go through a particular sequence but doesn't properly prevent them from diverging from this sequence, vulnerabilities can occur.

To probe for this kind of vulnerability:
- While analyzing the application's behavior, note features that require a particular sequence of steps
- For each of these sequences:
	- Analyze each of the requests in the sequence to understand exactly what's happening
	- With a solid understanding of what's happening, would submitting requests out of order or omitting particuar requests altogether lead to a vulnerability?

Examples:
	- [PortSwigger Web Security Academy Authentication Lab - 2FA simple bypass](https://github.com/tgihf/writeups/blob/master/port-swigger-web-academy/authentication/multi-factor-authentication/07%20-%202FA%20simple%20bypass.md)
	- [PortSwigger Web Security Academy Business Logic Flaws Lab - Insufficient workflow validation](https://github.com/tgihf/writeups/blob/master/port-swigger-web-academy/business-logic-flaws/07%20-%20Insufficient%20workflow%20validation.md)
	- [PortSwigger Web Security Academy Business Logic Flaws Lab - Authentication bypass via flawed state machine](https://github.com/tgihf/writeups/blob/master/port-swigger-web-academy/business-logic-flaws/08%20-%20Authentication%20bypass%20via%20flawed%20state%20machine.md)

---

## [Domain-specific flaws](https://portswigger.net/web-security/logic-flaws/examples#domain-specific-flaws)

Every application exists to solve one or more problems in a specific domain. As a result, every application contains logic that is specific to its domain. By understanding the application's domain, you can determine what kind of inputs the application is supposed to allow and analyze its behavior when fed "invalid" inputs.

Shopping application? Prices should always be positive. Travel application? Distance should always be positive. These are cursory examples. Many application domains are incredible complex and thus also require complex application logic.

How do you find and exploit domain-specific flaws?

1. Understand the domain
2. Analyze the application's functionality and inputs
3. Based on your understanding of the domain, enter "invalid" inputs and analyze the application's responses to determine if a vulnerability exists

Examples:
- [PortSwigger Web Security Academy Business Logic Flaws Lab - Flawed enforcement of business logic](https://github.com/tgihf/writeups/blob/master/port-swigger-web-academy/business-logic-flaws/09%20-%20Flawed%20enforcement%20of%20business%20rules.md)
- [PortSwigger Web Security Academy Business Logic Flaws Lab - Infinite money logic flaw](https://github.com/tgihf/writeups/blob/master/port-swigger-web-academy/business-logic-flaws/10%20-%20Infinite%20money%20logic%20flaw.md)

---

## [Providing an Encryption Oracle](https://portswigger.net/web-security/logic-flaws/examples#providing-an-encryption-oracle)

An **encryption oracle** is a vulnerability in which user-controllable input is encrypted and the resulting ciphertext is made available to the user in some way.

This allows an attacker to encrypt an input. If another endpoint on the application requires input encrypted via the same algorithm and key, the attacker can leverage the encryption oracle to encrypt their input and pass it to the other endpoint.

