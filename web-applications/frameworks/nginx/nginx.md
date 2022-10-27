# Nginx

---

## Interesting Files & Directories

This is very similar to [[apache#Interesting Files Directories|Apache's interesting files and directories]].

### `/etc/nginx/sites-available/`

Contains configuration files for all of the **available** (but not necessarily enabled) Nginx virtual hosts, each of which is its own web site with its own configuration.

### `/etc/nginx/sites-available/default`

The configuration file for the default Nginx web server (virtual host). This file should always exist for any Nginx installation.

### `/etc/nginx/sites-enabled/`

Contains symbolic links to virtual host configuration files in `/etc/nginx/sites-available/` that are **enabled**. Unless there is a symbolic link in this directory to a virtual host configuration file in `/etc/nginx/sites-available/`, you will not be able to access that virtual host.

### `/etc/nginx/sites-enabled/default`

By default, a symbolic link to `/etc/nginx/sites-available/000-default.conf`. Delete this file to disable access to the default web server.
