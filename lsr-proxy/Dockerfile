FROM registry.fedoraproject.org/fedora:34

RUN dnf update -y && dnf install -y \
    squid openssl && dnf clean all

COPY squid.conf /etc/squid/squid.conf
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
RUN cd /etc/squid; \
    mkdir ssl_cert; \
    chmod 700 ssl_cert; \
    cd ssl_cert; \
    openssl req -new -newkey rsa:2048 -sha256 -days 365 -nodes -x509 -extensions v3_ca \
    -subj "/C=US/ST=NC/L=Raleigh/O=LSR/OU=RHEL/CN=localhost" -keyout myCA.pem -out myCA.pem; \
    /usr/lib64/squid/security_file_certgen -c -s /var/spool/squid/ssl_db -M 4MB; \
    mkdir -p /var/lib/squid; \
    chown squid:squid -R /var/spool/squid /etc/squid/ssl_cert /var/lib/squid; \
    chgrp -R 0 /var/spool/squid /etc/squid/ssl_cert /var/lib/squid; \
    chmod -R g=u /var/spool/squid /etc/squid/ssl_cert /var/lib/squid

RUN /usr/sbin/squid -N -z; chgrp -R 0 /var/lib/squid; chmod -R g=u /var/lib/squid

EXPOSE 3128/tcp
ENTRYPOINT ["/entrypoint.sh"]
