FROM node:lts-slim

RUN apt-get update && apt-get install -y \
    dumb-init \
    git \
    curl \
    jq \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

RUN npm install -g opencode-ai \
    && npm cache clean --force

USER node
WORKDIR /workspace

ENTRYPOINT ["dumb-init", "--"]
CMD ["opencode"]