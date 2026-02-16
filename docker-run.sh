#!/bin/bash

# Pull latest image from GitHub Container Registry
IMAGE="ghcr.io/angelo-v/opencode-sandbox:latest"

echo "Pulling latest image: ${IMAGE}"
docker pull "${IMAGE}"

echo "Starting OpenCode container..."
docker run -it \
  --cap-drop=ALL \
  --network=bridge \
  -v $(pwd):/workspace:rw \
  -v ~/.opencode:/home/node/.opencode:ro \
  -v ~/.config/opencode:/home/node/.config/opencode:ro \
  -v ~/.local/share/opencode:/home/node/.local/share/opencode:rw \
  -v ~/.cache/opencode/:/home/node/.cache/opencode/:rw \
  -v ~/.local/state/opencode/:/home/node/.local/state/opencode/:rw \
  -w /workspace \
  "${IMAGE}"
