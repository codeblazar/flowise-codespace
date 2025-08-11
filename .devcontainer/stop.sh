#!/bin/bash
set -e

echo "[INFO] Stopping Flowise and Qdrant containers..."
docker stop flowise qdrant-server 2>/dev/null || true

echo "[INFO] Removing Flowise and Qdrant containers..."
docker rm flowise qdrant-server 2>/dev/null || true

echo "[INFO] All containers stopped and removed."
