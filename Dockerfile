FROM node:20-bookworm-slim

USER root

# Dependências do sistema + LibreOffice
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

# Instala n8n
RUN npm install -g n8n

# Diretórios
RUN mkdir -p /data \
    /tmp/libreoffice-profile \
    /tmp/convert && \
    chmod -R 777 /tmp

# Variáveis
ENV N8N_PORT=5678
ENV N8N_HOST=0.0.0.0
ENV HOME=/root
ENV XDG_CONFIG_HOME=/tmp/libreoffice-profile
ENV TMPDIR=/tmp/convert
ENV SAL_USE_VCLPLUGIN=gen
ENV TZ=America/Sao_Paulo

EXPOSE 5678

CMD ["n8n"]

