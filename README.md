# mailserver

## Initialization

* prepare config files:
```
cp docker-compose.yml.dist docker-compose.yml
cp env.dist .env
```

* edit variables in .env

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

## Run (setup)

```
docker-compose up -d 
```

## letsencrypt

* create a certificate:
```
docker-compose exec letsencrypt bash -c 'certbot certonly --standalone -d $MYHOSTNAME --deploy-hook /usr/local/sbin/restart-containers.py'
```

## postfixadmin

* visit: https://MYHOSTNAME/postfixadmin/setup.php (to create db and admin user)
* create admin user i.e. "admin@MYHOSTNAME"

* Login

* create new Domain:
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

* create domains as desired

* add first mailbox for "main" user (admin):
```
User: USERNAME
Domain: MYHOSTNAME
...
```

* add alias for default domain:
```
Alias: admin
Domain: MYHOSTNAME
To: name of the first mailbox (admin)
```

* change aliases of default domain:
```
abuse, hostmaster, postmaster, webmaster --> admin@MYHOSTNAME
```

optional:
* add alias with different domain to a mailbox...

