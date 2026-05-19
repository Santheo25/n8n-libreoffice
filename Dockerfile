FROM n8nio/n8n:latest

USER root

RUN apk update && apk add --no-cache \
    libreoffice \
    fontconfig \
    ttf-dejavu \
    msttcorefonts-installer \
    && update-ms-fonts \
    && fc-cache -f

USER node

