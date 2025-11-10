FROM mcr.microsoft.com/devcontainers/base:ubuntu
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        lua5.1 \
        luarocks \
        git \
        build-essential \
        curl \
    && luarocks install luacheck \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

USER vscode
