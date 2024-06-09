# syntax = docker/dockerfile:labs
ARG ${BRAND}
FROM ${BRAND}-php

LABEL author="admin@magenx.com"
LABEL source="https://github.com/magenx/Magento-2-docker-email-config"

ARG TIMEZONE
ARG VIMBADMIN_ROOT_PATH
ARG VIMBADMIN_WEB_ROOT_PATH

RUN <<EOF
    apk update
    apk add --update --no-cache git
    mkdir -p ${VIMBADMIN_ROOT_PATH}
    git clone https://github.com/opensolutions/ViMbAdmin.git ${VIMBADMIN_ROOT_PATH}
    cd ${VIMBADMIN_ROOT_PATH}
    composer install --prefer-dist --no-dev
EOF

RUN <<EOF
    ln -snf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime
    echo ${TIMEZONE} > /etc/timezone
    ln -s /usr/bin/${PHP_VERSION} /usr/local/bin/php
EOF

