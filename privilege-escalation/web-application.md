# Privilege Escalation from Web Server Account

Often after exploiting a web application, you'll obtain a reverse shell as the particularly restrictive user account that the web application was running under (i.e., `www-data` or `apache`).

The process of escalating privileges from a restrictive web application user account involves careful enumeration. Work through the following steps for consistency and thoroughness.

---

## 1. Check web app directory for credentials

Check the web application directory (i.e, `/var/www/html`) for credentials or other helpful information. Prioritize configuration and database files.