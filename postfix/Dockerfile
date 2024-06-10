# syntax = docker/dockerfile:labs
FROM alpine:3.20.0

LABEL author="admin@magenx.com"
LABEL source="https://github.com/magenx/Magento-2-docker-email-config"

ARG VIMBADMIN_DOMAIN
ARG VIMBADMIN_HOSTNAME
ARG VIMBADMIN_ADMIN_EMAIL

ARG VIMBADMIN_SSL_CRT
ARG VIMBADMIN_SSL_KEY

ARG VIMBADMIN_DATABASE_USER
ARG VIMBADMIN_DATABASE_PASSWORD
ARG VIMBADMIN_DATABASE_HOST
ARG VIMBADMIN_DATABASE

RUN <<EOF
    apk update
    apk add --update --no-cache postfix postfix-mysql
EOF

COPY config/ /etc/postfix/

RUN <<EOF
    sed -i "s,VIMBADMIN_SSL_CRT,${VIMBADMIN_SSL_CRT}," /etc/postfix/main.cf
    sed -i "s,VIMBADMIN_SSL_KEY,${VIMBADMIN_SSL_KEY}," /etc/postfix/main.cf
    sed -i "s/VIMBADMIN_HOSTNAME/${VIMBADMIN_HOSTNAME}/" /etc/postfix/main.cf
    sed -i "s/VIMBADMIN_DOMAIN/${VIMBADMIN_DOMAIN}/" /etc/postfix/main.cf
    sed -i "s/VIMBADMIN_ADMIN_EMAIL/${VIMBADMIN_ADMIN_EMAIL}/" /etc/postfix/main.cf
EOF

COPY <<EOF /etc/postfix/mysql/virtual-alias-maps.cf
     user = ${VIMBADMIN_DATABASE_USER}
     password = ${VIMBADMIN_DATABASE_PASSWORD}
     hosts = ${VIMBADMIN_DATABASE_HOST}
     dbname = ${VIMBADMIN_DATABASE}
     query = SELECT goto FROM alias WHERE address = '%s' AND active = '1'
EOF

COPY <<EOF /etc/postfix/mysql/virtual-mailbox-domains.cf
     user = ${VIMBADMIN_DATABASE_USER}
     password = ${VIMBADMIN_DATABASE_PASSWORD}
     hosts = ${VIMBADMIN_DATABASE_HOST}
     dbname = ${VIMBADMIN_DATABASE}
     query = SELECT domain FROM domain WHERE domain = '%s' AND backupmx = '0' AND active = '1'
EOF

COPY <<EOF /etc/postfix/mysql/virtual-mailbox-maps.cf
     user = ${VIMBADMIN_DATABASE_USER}
     password = ${VIMBADMIN_DATABASE_PASSWORD}
     hosts = ${VIMBADMIN_DATABASE_HOST}
     dbname = ${VIMBADMIN_DATABASE}
     query = SELECT maildir FROM mailbox WHERE username = '%s' AND active = '1'
EOF

VOLUME ["/etc/postfix"]

CMD ["/usr/sbin/postfix", "start-fg"]
