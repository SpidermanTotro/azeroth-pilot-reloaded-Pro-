FROM ubuntu:22.04

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    lua5.1 \
    luarocks \
    build-essential \
    ca-certificates \
    wget \
 && rm -rf /var/lib/apt/lists/*

RUN luarocks --local install luacheck 1.2.0 || luarocks install luacheck

CMD ["/bin/bash"]
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
