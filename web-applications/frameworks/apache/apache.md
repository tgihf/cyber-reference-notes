# [Apache HTTP Server](https://httpd.apache.org/)

> The Apache HTTP Server Project is an effort to develop and maintain an open-source HTTP server for modern operating systems including UNIX and Windows. The goal of this project is to provide a secure, efficient and extensible server that provides HTTP services in sync with the current HTTP standards.

---

## Interesting Files & Directories

### `/etc/apache2/sites-available/`

Contains configuration files for all of the **available** (but not necessarily enabled) Apache Virtual Hosts, each of which is its own web site with its own configuration.

### `/etc/apache2/sites-available/000-default.conf`

The configuration file for the default Apache web server (virtual host). This file should always exist for any Apache installation.

### `/etc/apache2/sites-enabled/`

Contains symbolic links to virtual host configuration files in `/etc/apache2/sites-available/` that are **enabled**. Unless there is a symbolic link in this directory to a virtual host configuration file in `/etc/apache2/sites-available/`, you will not be able to access that virtual host.

### `/etc/apache2/sites-enabled/000-default.conf`

By default, a symbolic link to `/etc/apache2/sites-available/000-default.conf`. Delete this file to disable access to the default web server.

### `.htaccess`

Configuration file for a particular **directory** and all of its **subdirectories**.
