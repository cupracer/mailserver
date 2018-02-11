# mailserver

## Initialization

* prepare config files:
```
cp docker-compose.yml.sample docker-compose.yml
cp .env.sample .env
```

* edit variables in .env

## Run (setup)

```
docker-compose up -d 
```

## letsencrypt

* create a certificate:
```
docker-compose exec letsencrypt bash
certbot certonly --webroot -w /srv/www/htdocs -d $MYHOSTNAME
docker-compose restart haproxy
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

## RoundCube

```
docker-compose exec roundcube bash
```

* Add 
```
$config['enable_installer'] = true;
```
to /etc/roundcubemail/config.inc.php

* Visit:
```
https://MYHOSTNAME/roundcubemail/installer/
```

* Click "next"

* Optional: check IMAP/SMTP

* disable installer mode:
```
docker-compose exec roundcube bash
```

Remove
```
$config['enable_installer'] = true;
```
from /etc/roundcubemail/config.inc.php

