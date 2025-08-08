#!/bin/bash
set -e

# Start Chroma
echo "[DEBUG] Starting Chroma on port 8000..."
chroma run --path /data/chroma --host 0.0.0.0 --port 8000 &

# Wait for Chroma health endpoint
until curl -s http://localhost:8000/api/v2/heartbeat >/dev/null; do
  echo "[DEBUG] Waiting for Chroma..."
  sleep 1
done

# Start Flowise
echo "[DEBUG] Starting Flowise on port 7860..."
npx flowise start --port 7860