# syntax = docker/dockerfile:labs
FROM alpine:3.20.0

LABEL author="admin@magenx.com"
LABEL source="https://github.com/magenx/Magento-2-docker-email-config"

ARG VIMBADMIN_ADMIN_EMAIL

ARG VIMBADMIN_SSL_CRT
ARG VIMBADMIN_SSL_KEY

ARG VIMBADMIN_DATABASE_USER
ARG VIMBADMIN_DATABASE_PASSWORD
ARG VIMBADMIN_DATABASE_HOST
ARG VIMBADMIN_DATABASE_NAME

RUN <<EOF
    apk update
    apk add --update --no-cache dovecot dovecot-submissiond dovecot-pop3d dovecot-mysql dovecot-lmtpd dovecot-pigeonhole-plugin
    groupadd -g 5000 vmail
    useradd -g vmail -u 5000 vmail -d /home/vmail -m -s /sbin/nologin
    mkdir /home/vmail
    chown vmail:vmail /home/vmail
EOF

COPY dovecot.conf dovecot-sql.conf /etc/dovecot/

RUN <<EOF
    sed -i "s,VIMBADMIN_SSL_CRT,${VIMBADMIN_SSL_CRT}," /etc/dovecot/dovecot.conf
    sed -i "s,VIMBADMIN_SSL_KEY,${VIMBADMIN_SSL_KEY}," /etc/dovecot/dovecot.conf
    sed -i "s/VIMBADMIN_ADMIN_EMAIL/${VIMBADMIN_ADMIN_EMAIL}/" /etc/dovecot/dovecot.conf
    sed -i "s/VIMBADMIN_DATABASE_HOST/${VIMBADMIN_DATABASE_HOST}/" /etc/dovecot/dovecot-sql.conf
    sed -i "s/VIMBADMIN_DATABASE_NAME/${VIMBADMIN_DATABASE_NAME}/" /etc/dovecot/dovecot-sql.conf
    sed -i "s/VIMBADMIN_DATABASE_USER/${VIMBADMIN_DATABASE_USER}/" /etc/dovecot/dovecot-sql.conf
    sed -i "s/VIMBADMIN_DATABASE_PASSWORD/${VIMBADMIN_DATABASE_PASSWORD}/" /etc/dovecot/dovecot-sql.conf
EOF

VOLUME ["/etc/dovecot"]

CMD ["/usr/sbin/dovecot", "-F"]
