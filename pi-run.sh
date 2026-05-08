#!/bin/bash

# Pull latest image from GitHub Container Registry
IMAGE="ghcr.io/angelo-v/pi-sandbox:latest"

echo "Pulling latest image: ${IMAGE}"
docker pull "${IMAGE}"

echo "Starting pi-coding-agent container..."
docker run -it \
  --cap-drop=ALL \
  --network=host \
  -v $(pwd):/workspace:rw \
  -v ~/.pi:/home/node/.pi:rw \
  -v ~/.agents:/home/node/.agents:ro \
  -w /workspace \
  "${IMAGE}"
