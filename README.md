## Flowise Account Setup

When you access Flowise for the first time in your browser, you will be prompted to set up your administrator account (name, email, and password) via the web UI. You do not need to pre-populate any credentials in the .env file.

If you forget your password, use the password reset or recovery options in the Flowise UI.
# Flowise Codespace (Flowise + Qdrant)

This Codespace runs Flowise and Qdrant together, fully reproducibly.

## Requirements
- GitHub Codespaces (or VS Code Dev Containers)
- Node.js 20 (pinned via `.nvmrc`)
- Docker available in the Codespace (for Qdrant)


## How to Start Flowise


## How to Start and Stop Flowise

### Start the stack
```bash
bash .devcontainer/start.sh
```
This will:
- Stop and remove any running Flowise and Qdrant containers
- Start both services with your settings from `.env`
- Wait for Flowise to be ready
- Print the correct URL to access Flowise when ready (in Codespaces, use the printed URL or the "Forwarded Address" in the Ports tab)

**What to look for:**
- Wait for the script to print: `[INFO] Flowise is ready! You can now access it at ...`
- Open the printed URL in your browser (in Codespaces, it will look like `https://<your-codespace-name>-7860.app.github.dev/`)
- If you see `Error: listen EADDRINUSE: address already in use :::7860`, make sure no other Flowise instance is running.

### Stop the stack
```bash
bash .devcontainer/stop.sh
```
This will stop and remove both Flowise and Qdrant containers. Wait for the script to print `[INFO] All containers stopped and removed.`

---

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
