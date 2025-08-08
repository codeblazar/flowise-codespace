
#!/bin/bash
set -e
export PATH="$HOME/.local/bin:$PATH"

echo "[INFO] Starting Chroma (via Python) on port 8000..."
chromadb run --path /data/chroma --host 0.0.0.0 --port 8000 &

# Wait for Chroma to be ready
until curl -s http://localhost:8000/api/v2/heartbeat >/dev/null; do
  echo "[INFO] Waiting for Chroma..."
  sleep 1
done

echo "[INFO] Starting Flowise on port 7860..."
npx flowise start --port 7860 --config ./flowise.json