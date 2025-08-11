# Flowise Codespace (Flowise + Qdrant)

This Codespace runs Flowise and Qdrant together, fully reproducibly.

## Requirements
- GitHub Codespaces (or VS Code Dev Containers)
- Node.js 20 (pinned via `.nvmrc`)
- Docker available in the Codespace (for Qdrant)


## How to Start Flowise

You can start Flowise and Qdrant using either the provided script or Docker Compose.


### Option 1: Using the start script
```bash
bash .devcontainer/start.sh
```
This will:
- Stop and remove any running Flowise and Qdrant containers
- Start both services using Docker Compose with settings from `.env`
- Wait for Flowise to be ready (shows output until you see `Server is listening at ...`)
- Tell you when you can access Flowise in your browser

**Wait for:**
- The script to print: `Server is listening at http://localhost:7860` (or your configured port)
- Then open your browser to that URL (or use the Codespaces forwarded port)

If you see `Error: listen EADDRINUSE: address already in use :::7860`, make sure no other Flowise instance is running.

### Option 2: Using Docker Compose
```bash
cd .devcontainer
docker compose up -d
```
This will start both Qdrant and Flowise as background containers.

**Wait for:**
- Run `docker compose logs -f flowise` and look for `🎉 [server]: All initialization steps completed successfully!`

## Accessing Flowise
- Open your browser to: http://localhost:7860 (or use the Codespaces forwarded port)
- Default login (if enabled):
	- Username: `admin`
	- Password: `admin`

## Accessing Qdrant
- Qdrant API: http://localhost:6333

## Data & Persistence
- Flowise data: `./data/.flowise` (SQLite DB, logs, uploads)
- Qdrant data: `./data/qdrant` (vector DB storage)
- Both are volume-mounted for persistence and are ignored by git.

## Stopping & Cleaning Up
```bash
# If using the script, just Ctrl+C to stop Flowise
# To stop and remove containers (if using Docker Compose):
docker compose down
# Or manually:
docker stop flowise qdrant-server
docker rm flowise qdrant-server
```

## Troubleshooting
- If you see port conflicts, make sure no other Flowise or Qdrant containers are running.
- If you see dependency errors, try pulling the latest images or reinstalling dependencies.

---

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
