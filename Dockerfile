# ==========================================================
# n8n + LibreOffice otimizado para Railway
# DOCX -> PDF (headless)
# ==========================================================

FROM n8nio/n8n:latest

USER root

# Atualiza repositórios
RUN apk update && apk upgrade

# ----------------------------------------------------------
# Dependências essenciais
# ----------------------------------------------------------
RUN apk add --no-cache \
    libreoffice \
    libreoffice-writer \
    libreoffice-calc \
    libreoffice-impress \
    libreoffice-lang-en \
    libreoffice-lang-pt-br \
    fontconfig \
    bash \
    curl \
    tzdata \
    ca-certificates \
    ttf-dejavu \
    ttf-liberation \
    font-noto \
    font-noto-cjk \
    msttcorefonts-installer

# ----------------------------------------------------------
# Instala fontes Microsoft
# (fundamental para DOCX não quebrar layout)
# ----------------------------------------------------------
RUN update-ms-fonts && fc-cache -f

# ----------------------------------------------------------
# Diretórios temporários para LibreOffice
# evita lockfile/profile corruption
# ----------------------------------------------------------
RUN mkdir -p /tmp/libreoffice-profile && \
    mkdir -p /tmp/convert && \
    chmod -R 777 /tmp/libreoffice-profile && \
    chmod -R 777 /tmp/convert && \
    chmod -R 777 /tmp

# ----------------------------------------------------------
# Ajustes de permissão do usuário node
# ----------------------------------------------------------
RUN mkdir -p /home/node/.config && \
    chown -R node:node /home/node && \
    chmod -R 755 /home/node

# ----------------------------------------------------------
# Variáveis importantes para Railway
# ----------------------------------------------------------
ENV TZ=America/Sao_Paulo

ENV HOME=/home/node
ENV USER=node

# evita erro de profile do libreoffice
ENV XDG_CONFIG_HOME=/tmp/libreoffice-profile

# temp files
ENV TMPDIR=/tmp/convert

# evita travamentos java/headless
ENV SAL_USE_VCLPLUGIN=gen

# reduz logs inúteis
ENV N8N_LOG_LEVEL=warn

USER node

EXPOSE 5678

CMD ["n8n"]