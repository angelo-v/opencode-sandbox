FROM node:lts-slim

RUN apt-get update && apt-get install -y \
    dumb-init \
    git \
    curl \
    jq \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean \
    && npm install -g opencode-ai

# Install playwright-cli with chrome browser
RUN  npm install -g @playwright/cli \
    && npx playwright install chrome \
    && npm cache clean --force

# replace the original chrome binary with a symlink calling it with --no-sandbox, so that it can start inside docker
RUN mv /opt/google/chrome/chrome /opt/google/chrome/chrome.real \
    && echo '#!/bin/bash\nexec /opt/google/chrome/chrome.real --no-sandbox "$@"' \
    > /opt/google/chrome/chrome && chmod +x /opt/google/chrome/chrome

USER node

RUN mkdir -p ~/.config ~/.local ~/.cache

WORKDIR /workspace

ENTRYPOINT ["dumb-init", "--"]
CMD ["opencode"]