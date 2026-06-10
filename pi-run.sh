#!/bin/bash

# Pull latest image from GitHub Container Registry
IMAGE="ghcr.io/angelo-v/pi-sandbox:latest"

echo "Pulling latest image: ${IMAGE}"
docker pull "${IMAGE}"

echo "Starting pi-coding-agent container..."
DIR_NAME=$(basename "$(pwd)")

docker run -it \
  --cap-drop=ALL \
  --network=host \
  -v $(pwd):/workdir/${DIR_NAME}:rw \
  -v ~/.pi:/home/node/.pi:rw \
  -v ~/.wallaby:/home/node/.wallaby:ro \
  -v ~/.agents:/home/node/.agents:ro \
  -e GNUPGHOME=/home/node/.pi/gnupg \
  -e PASSWORD_STORE_DIR=/home/node/.pi/secrets \
  -w /workdir/${DIR_NAME} \
  "${IMAGE}"
