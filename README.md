# cupracer/mailserver

[![GitHub issues](https://img.shields.io/github/issues/badges/shields.svg?style=plastic)]()

This is a dockerized full-stack e-mail server. It is primarily based on openSUSE Leap (except MariaDB and Redis) and relies on openSUSE packages. It is prepared to be run as a Docker Compose project and uses a ready-to-use configuration which I built according to my preferences. Nevertheless, please feel free to suggest improvements or to change whatever you like in your personal setup.

## Features / Technologies

* Postfix
  - MariaDB backend
  - SMTP/Submission (incl. TLS support)
  - Postscreen
* Dovecot
  - MariaDB backend
  - IMAP (incl. TLS support)
  - LMTP
  - Quota
  - Sieve
* Rspamd
  - Redis backend
  - ClamAV
  - DKIM
  - ARC
  - Greylisting
* Postfix Admin
  - MariaDB backend
* Roundcube Webmail
  - MariaDB backend
* Let's Encrypt
* HAProxy
  - SSL termination

## Why?

tbd.

## Install

* Clone this project to a directory with a desired project name:
```
git clone https://github.com/cupracer/mailserver.git /opt/docker/compose/mail
```

* Prepare config files:
```
cd /opt/docker/compose/mail
cp docker-compose.yml.dist docker-compose.yml
cp env.dist .env
```

* Edit variables in .env (it's strongly advised to change all passwords!). Following are the defaults:
```
# Fully qualified domain name (FQDN) of the mail server instance
MYHOSTNAME=mail.example.de

# MySQ root password for shared Dovecot/Postfix/PostfixAdmin database
MYSQL_ROOT_PASSWORD=secret

# MySQ app password used by Dovecot/Postfix/PostfixAdmin
MYSQL_PASSWORD=secret

# MySQ root password for Roundcube database
ROUNDCUBE_MYSQL_ROOT_PASSWORD=secret

# MySQ app password used by Roundcube
ROUNDCUBE_MYSQL_PASSWORD=secret

# PostfixAdmin setup password to create admin users
POSTFIXADMIN_SETUP_PASSWORD=secret

# Password to access Rspamd web GUI
RSPAMD_WEB_PASSWORD=secret

# Use DKIM feature in Rspamd
RSPAMD_USE_DKIM=false

# Use ARC feature in Rspamd (requires RSPAMD_USE_DKIM)
RSPAMD_USE_ARC=false

# Rspamd and PostfixAdmin are secured by HTTP basic auth (user "admin")
WEB_PASSWORD=secret
```

* Star the project for the first time:
```
docker-compose up -d 
```

* Create an SSL certificate with Let's Encrypt:
```
docker-compose exec letsencrypt bash -c 'certbot certonly --standalone -d $MYHOSTNAME --deploy-hook /usr/local/sbin/restart-containers.py'
```
Please continue only if this was successful!

* Setup PostfixAdmin

  - Visit: https://MYHOSTNAME/postfixadmin/setup.php (to create db and admin user)
  - Create an admin user i.e. "admin@MYHOSTNAME"
  - Login as admin user: https://MYHOSTNAME/postfixadmin/
  - Create a new Domain for the FQDN of your mail server:
```
Domain: MYHOSTNAME
Description: default
Aliases: 0
Mailboxes: 0
Mailbox quota: 0
Domain quota: 0
is Backup MX: no
active: yes
add default aliases: yes
```
  - Create additional domains as desired
  - Add a first mailbox for the admin user:
```
User: USERNAME
Domain: MYHOSTNAME
...
```
  - Add an alias for the default domain (FQDN of your mail server):
```
Alias: admin
Domain: MYHOSTNAME
To: name of the first mailbox
```
  - Change aliases of default domain:
```
abuse, hostmaster, postmaster, webmaster --> admin@MYHOSTNAME
```

* Visit https://MYHOSTNAME/roundcubemail/ and login with you mailbox credentials.
* Visit https://MYHOSTNAME/rspamd/ to monitor Rspamd's activities.

* If you decided to use DKIM, please run the following command to get you DKIM public key:
```
docker-compose exec rspamd bash -c 'info.sh'
```

Have fun!

