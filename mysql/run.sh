systemctl stop amavis amavis-mc amavisd-snmp-subagent clamav-daemon clamav-freshclam dovecot fail2ban memcached mysql nginx php7.0-fpm postfix sogo spamassassin uwsgi
rm -v /var/run/clamav/clamd.ctl
for i in `find /etc/service/ | grep run`; do 
    bash ${i} &
done

wait 
