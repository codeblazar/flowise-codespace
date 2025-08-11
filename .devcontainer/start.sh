#!/bin/bash
set -e

# Detect Codespaces environment and set URL accordingly
if [ -n "$CODESPACE_NAME" ]; then
  FLOWISE_URL="https://$CODESPACE_NAME-7860.app.github.dev/"
else
  FLOWISE_URL="http://localhost:${PORT:-7860}"
fi

echo "[INFO] Stopping and removing any existing Flowise and Qdrant containers..."
docker stop flowise qdrant-server 2>/dev/null || true
docker rm flowise qdrant-server 2>/dev/null || true

echo "[INFO] Starting Flowise and Qdrant using Docker Compose..."
cd "$(dirname "$0")"
docker compose up -d

echo "[INFO] Waiting for Flowise to be ready..."
until docker compose logs flowise 2>&1 | grep -q "Server is listening at"; do
  sleep 2
done

echo "[INFO] Flowise is ready! You can now access it at $FLOWISE_URL"
