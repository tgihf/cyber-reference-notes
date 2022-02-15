# Web Application Username Enumeration

Username enumeration is possible when an attacker is able to observe changes in a web application's responses in order to identify whether a given username is valid. Username enumeration is often possible on **login pages** and **registration forms**, but can also be possible in restful applications where usernames are in the URI (i.e., `/users/tgihf`). To determine the difference between a valid username and an invalid username, pay attention to the following:
1. **Response status codes**: For example, a 200 for a valid username and 404 for an invalid username. The status code *should* be the same either way, but it often isn't.
2. **Error messages in the response**: For example, "That username doesn't exist."
3. **Response times**: If the web application synchronously goes through the process of checking the username, it could take longer or shorter to execute than an invalid username and thus, tip off the fact that the username is valid.

Recommended tool: [[patator]]

---

## Username Enumeration via Account Lockout

If a target application employs account lockout based on a certain number of failed login attempts, you can enumerate users by submitting just enough requests to lock out a user for each username in a list. The accounts that get locked have valid usernames.
