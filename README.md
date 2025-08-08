# Flowise Codespace (Flowise + Qdrant)

This Codespace runs Flowise and Qdrant together, fully reproducibly.

## Requirements
- GitHub Codespaces (or VS Code Dev Containers)
- Node.js 20 (pinned via `.nvmrc`)
- Docker available in the Codespace (for Qdrant)

## Start
```bash
bash .devcontainer/start.sh
```
This will:
- Start Qdrant in Docker on ports 6333/6334
- Wait for Qdrant to be ready
- Start Flowise on port 7860 using local data at `./data/.flowise`

Access via forwarded ports in Codespaces:
- Flowise UI: http://localhost:7860
- Qdrant API: http://localhost:6333

## Data & persistence
- Runtime data lives in `./data/.flowise` (SQLite DB, logs, uploads)
- `data/` is ignored by Git to keep commits clean

## Stop / clean
```bash
# Stop Flowise (Ctrl+C if running in foreground)
# Remove Qdrant container if running
docker rm -f qdrant-server 2>/dev/null || true
```

## Notes
- Inside the Codespace/container, `localhost` refers to the dev container.
- Your browser reaches it via Codespaces port forwarding.
- Flowise CLI flags used: `--PORT`, `--DATABASE_PATH`, `--LOG_PATH`.
- If you see Node version issues, use Node 20 (see `.nvmrc`).
