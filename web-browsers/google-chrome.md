# [Google Chrome](https://www.google.com/chrome/)

> Chrome is the most popular web browser in the world. It stores each user's browsing data in [[sqlite|SQLite]] databases in each user's own profile directory. This browsing data can provide a treasure trove of useful and sensitive information.

---

## User Profile Directory

Each user that uses Google Chrome has their own "profile," which is a directory that contains all of that user's Chrome browsing data, from history to cookies to extensions and more. **Most of these artifacts are found in the `Default/` or `ChromeDefaultData/` directories within the profile directory.**

User profile paths:

- Linux: `/home/$USERNAME/.config/google-chrome/`
- Windows: `C:\Users\$USERNAME\AppData\Local\Google\Chrome\User Data\`
- Mac: `/Users/$USERNAME/Library/Application Support/Google/Chrome/`

---

## Artifacts

These artifacts are found in the `Default/` or `ChromeDefaultData/` directories inside the user's [[google-chrome#User Profile Directory|profile directory]]. If not a directory, these are [[sqlite|SQLite]] database files.

### `History`

URLs, downloads, and even searched keywords

### `Cookies`

The user's cookies

### `Web Data`

Form history

### `Login Data`

Login information (usernames, passwords, etc)

### `Extensions/` or `Local Extension Settings/`

A directory that contains a directory full of source code, configuration files, and [[sqlite|SQLite]] databases for each installed browser extension.

---

## References

[HackTricks - Browser Artifacts](https://www.google.com/search?q=hacktricks+google+chrome&rlz=1C1OPNX_enUS980US980&oq=hacktricks+google+chrome&aqs=chrome..69i57j33i160l2.2267j0j4&sourceid=chrome&ie=UTF-8)

[ForensicsWiki - Google Chrome](https://forensicswiki.xyz/page/Google_Chrome)

[Infosec Insitute - Browser Forensics Google Chrome](https://resources.infosecinstitute.com/topic/browser-forensics-google-chrome/)

