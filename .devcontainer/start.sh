
#!/bin/bash
set -e

export PATH="$HOME/.local/bin:$PATH"


echo "[INFO] Stopping and removing any existing Qdrant container..."
docker stop qdrant-server 2>/dev/null || true
docker rm qdrant-server 2>/dev/null || true

echo "[INFO] Starting Qdrant (via Docker) on port 6333..."
docker run -d --name qdrant-server -p 6333:6333 -p 6334:6334 -v "$PWD/../data/qdrant:/qdrant/storage" qdrant/qdrant &


# Wait for Qdrant to be ready
until curl -s http://localhost:6333/collections >/dev/null; do
  echo "[INFO] Waiting for Qdrant..."
  sleep 1
done

echo "[INFO] Starting Flowise on port 7860..."
npx flowise start --PORT 7860 --DATABASE_PATH ./data/.flowise --LOG_PATH ./data/.flowise/logs
