# ==========================================================
# n8n + LibreOffice (Debian)
# Otimizado para Railway + DOCX -> PDF
# ==========================================================

FROM n8nio/n8n:latest

USER root

# Atualiza sistema e instala dependências
RUN apt-get update && apt-get install -y \
    libreoffice \
    libreoffice-writer \
    libreoffice-calc \
    libreoffice-impress \
    fonts-dejavu \
    fonts-liberation \
    fonts-noto \
    fonts-noto-cjk \
    fonts-crosextra-carlito \
    fonts-crosextra-caladea \
    fontconfig \
    curl \
    ca-certificates \
    bash \
    tzdata \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# ----------------------------------------------------------
# Diretórios temporários do LibreOffice
# ----------------------------------------------------------
RUN mkdir -p /tmp/libreoffice-profile && \
    mkdir -p /tmp/convert && \
    chmod -R 777 /tmp/libreoffice-profile && \
    chmod -R 777 /tmp/convert && \
    chmod -R 777 /tmp

# ----------------------------------------------------------
# Ajustes de permissões
# ----------------------------------------------------------
RUN mkdir -p /home/node/.config && \
    chown -R node:node /home/node

# ----------------------------------------------------------
# Variáveis do LibreOffice
# ----------------------------------------------------------
ENV TZ=America/Sao_Paulo
ENV HOME=/home/node
ENV USER=node

# evita profile lock do libreoffice
ENV XDG_CONFIG_HOME=/tmp/libreoffice-profile

# pasta temporária
ENV TMPDIR=/tmp/convert

# headless estável
ENV SAL_USE_VCLPLUGIN=gen

USER node

EXPOSE 5678

CMD ["n8n"]
