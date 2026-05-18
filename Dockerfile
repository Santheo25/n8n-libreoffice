FROM n8nio/n8n:latest

USER root

# Instala LibreOffice + fontes essenciais
RUN apk update && apk add --no-cache \
    libreoffice \
    libreoffice-writer \
    fontconfig \
    ttf-dejavu \
    ttf-liberation \
    font-noto \
    curl \
    bash \
    tzdata

# Pastas temporárias para LibreOffice
RUN mkdir -p /tmp/libreoffice-profile \
    /tmp/convert && \
    chmod -R 777 /tmp

# Configuração headless estável
ENV HOME=/home/node
ENV USER=node
ENV XDG_CONFIG_HOME=/tmp/libreoffice-profile
ENV TMPDIR=/tmp/convert
ENV SAL_USE_VCLPLUGIN=gen
ENV TZ=America/Sao_Paulo

RUN chown -R node:node /home/node

USER node

EXPOSE 5678

CMD ["n8n"]
