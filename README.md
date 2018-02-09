# mailserver

## Initialization

* copy docker-compose.yml.sample to docker-compose.yml
```
cp docker-compose.yml.sample docker-compose.yml
```

* copy .env.sample to .env
* edit variables in .env

## letsencrypt
* create a certificate:
```
docker-compose exec letsencrypt bash
rm -f /etc/certbot/cli.ini
certbot certonly --webroot -w /srv/www/htdocs -d $MYHOSTNAME
cp -vRL /etc/certbot/live/${MYHOSTNAME} /certs/
```

## postfixadmin

* visit: http://localhost:8080/postfixadmin/setup.php (to create db and admin user)

* create admin user i.e. "admin@<myhostname>"

* Login

* create new Domain:
```
Domain: <myhostname>
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
User: <username>
Domain: <myhostname>
...
```

* add alias for default domain:
```
Alias: admin
Domain: <myhostname>
To: name of the first mailbox (admin)
```

* change aliases of default domain:
```
abuse, hostmaster, postmaster, webmaster --> admin@<myhostname>
```

optional:
* add alias with different domain to a mailbox...

## RoundCube

* Init:
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
http://127.0.0.1:8081/roundcubemail/installer/
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

