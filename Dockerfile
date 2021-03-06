ARG NODE_VERSION=12

FROM node:${NODE_VERSION}-alpine AS builder

# Add Tini
ENV TINI_VERSION v0.19.0
RUN wget --no-check-certificate --quiet https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini-amd64 \
    && wget --no-check-certificate --quiet https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini-amd64.sha256sum \
    && echo "$(cat tini-amd64.sha256sum)" | sha256sum -c

RUN apk update && \
    apk add --no-cache tini
# Tini is now available at /sbin/tini
ENTRYPOINT ["/sbin/tini", "--"]