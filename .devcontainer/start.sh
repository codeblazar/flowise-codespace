
echo "[INFO] Stopping and removing any existing Qdrant container..."
docker stop qdrant-server 2>/dev/null || true
docker rm qdrant-server 2>/dev/null || true
echo "[INFO] Starting Qdrant (via Docker) on port 6333..."
docker run -d --name qdrant-server -p 6333:6333 -p 6334:6334 -v "$PWD/../data/qdrant:/qdrant/storage" qdrant/qdrant &
done
echo "[INFO] Starting Flowise on port 7860..."
npx flowise start --PORT 7860 --DATABASE_PATH ./data/.flowise --LOG_PATH ./data/.flowise/logs

#!/bin/bash
set -e

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

docker compose logs -f flowise | grep --line-buffered "Server is listening at" &
echo "[INFO] Flowise is ready! You can now access it at http://localhost:", "${PORT:-7860}"
