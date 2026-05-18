FROM n8nio/n8n:1.91.3

USER root

# Instala LibreOffice + dependências
RUN apt-get update && apt-get install -y \
    libreoffice \
    libreoffice-writer \
    fonts-dejavu \
    fonts-liberation \
    fonts-noto-core \
    fontconfig \
    curl \
    bash \
    tzdata \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Diretórios temporários
RUN mkdir -p /tmp/libreoffice-profile \
    /tmp/convert && \
    chmod -R 777 /tmp

# Configuração estável do LibreOffice headless
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

