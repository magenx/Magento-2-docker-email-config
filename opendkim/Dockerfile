# syntax = docker/dockerfile:labs
FROM alpine:3.20.0

LABEL author="admin@magenx.com"
LABEL source="https://github.com/magenx/Magento-2-docker-email-config"

RUN <<EOF
    apk update
    apk add --update --no-cache opendkim
EOF

COPY opendkim.conf /etc/opendkim/opendkim.conf
