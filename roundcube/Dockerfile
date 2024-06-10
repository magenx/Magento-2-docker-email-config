# syntax = docker/dockerfile:labs
ARG ${BRAND}
FROM ${BRAND}-php

LABEL author="admin@magenx.com"
LABEL source="https://github.com/magenx/Magento-2-docker-email-config"

ARG BRAND
ARG PHP_USER
ARG ROUNDCUBEMAIL_VERSION
ARG ROUNDCUBEMAIL_ROOT_PATH
ARG ROUNDCUBEMAIL_WEB_ROOT_PATH

RUN <<EOF
    apk update
    apk add --update --no-cache wget
    mkdir -p ${ROUNDCUBEMAIL_ROOT_PATH}
    cd ${ROUNDCUBEMAIL_ROOT_PATH}
		wget -qO - https://github.com/roundcube/roundcubemail/releases/download/${ROUNDCUBEMAIL_VERSION}/roundcubemail-${ROUNDCUBEMAIL_VERSION}-complete.tar.gz | tar -xz --strip 1
    chown -R ${BRAND}:${PHP_USER} ${ROUNDCUBEMAIL_ROOT_PATH}
    apk del wget
EOF
