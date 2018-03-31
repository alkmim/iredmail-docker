This is a fork of https://github.com/lejmr/iredmail-docker/ . 

This fork uses ubuntu as image instead of phusion/baseimage. 

# iRedMail Docker Container #

iRedMail allows to deploy an OPEN SOURCE, FULLY FLEDGED, FULL-FEATURED mail server in several minutes, for free. If several minutes is long time then this docker container can help you and deploy your mail server in seconds.

Current version of container uses MySQL for accounts saving. In the future the LDAP can be used, so pull requests are welcome. Container contains all components (Postfix, Dovecot, Fail2ban, ClamAV, Roundcube, and SoGo) and MySQL server. In order to customize container several environmental variables are allowed:

  * DOMAIN -  Primary domain which is used for iRedMail instalation (example.com)
  * HOSTNAME - server name (mail, so FQDN will be mail.example.com)
  * MYSQL_ROOT_PASSWORD - Root password for MySQL server installation
  * POSTMASTER_PASSWORD - Initial password for postmaster@DOMAIN. Password can be generated according to [wiki](http://www.iredmail.org/docs/reset.user.password.html). ({PLAIN}password)
  * TIMEZONE - Container timezone that is propagated to other components
  * SOGO_WORKERS - Number of SOGo workers which can affect SOGo interface performance.

## Persistent Data ##

Container is prepared to handle data as persistent using mounted folders for data. Folders prepared for initialization are:

 * /var/lib/mysql
 * /var/vmail
 * /var/lib/clamav

## Building ## 

```
git clone https://github.com/alkmim/iredmail-docker.git
cd iredmail-docker
docker build -t iredmail:latest mysql
```

## Running the contained ##

With all information prepared, let's test your new iRedMail server. Currently, we need to terminals to do that, but I will fix this soon. 

```
# Terminal 1
docker run --rm --privileged \
           -e "DOMAIN=example.com" \
           -e "HOSTNAME=mail" \
           -e "MYSQL_ROOT_PASSWORD=password" \
           -e "SOGO_WORKERS=1" \
           -e "TIMEZONE=GMT" \
           -e "POSTMASTER_PASSWORD={PLAIN}password" \
           -e "IREDAPD_PLUGINS=['reject_null_sender', 'reject_sender_login_mismatch', 'greylisting', 'throttle', 'amavisd_wblist', 'sql_alias_access_policy']" \
           -v /tmp/mysql:/var/lib/mysql \
           -v /tmp/vmail:/var/vmail \
           -v /tmp/clamav:/var/lib/clamav \
           --name=mysql iredmail:latest /sbin/init

# Terminal 2
docker exec -ti mysql /bin/bash
run.sh # Inside the container
```

