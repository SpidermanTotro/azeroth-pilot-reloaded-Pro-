FROM ubuntu:24.04

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    lua5.1 lua5.1-dev luarocks lua-socket lua-sec liblua5.1-0-dev build-essential git curl && \
    rm -rf /var/lib/apt/lists/*

RUN luarocks --local install luacheck 1.2.0 || luarocks install luacheck || true

WORKDIR /workspace

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
