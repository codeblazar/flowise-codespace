## Flowise Account Setup

When you access Flowise for the first time in your browser, you will be prompted to set up your administrator account (name, email, and password) via the web UI. 

If you forget your password, use the password reset or recovery options in the Flowise UI.
# Flowise Codespace (Flowise + Qdrant)

This Codespace runs Flowise and Qdrant together, fully reproducibly.

## Requirements
- GitHub Codespaces (or VS Code Dev Containers)
- Node.js 20 (pinned via `.nvmrc`)
- Docker available in the Codespace (for Qdrant)

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
- When the script prints the access URL, open it in your browser. In GitHub Codespaces, the URL will look like:
	- `https://<your-codespace-name>-7860.app.github.dev/`
- You can also find this URL in the "Forwarded Address" column in the Ports tab.
- Do not use `localhost`—it will not work from your local machine in Codespaces.

## Accessing Qdrant
- Qdrant API: Use the forwarded address for port 6333, e.g. `https://<your-codespace-name>-6333.app.github.dev/`

## Data & Persistence
- Flowise data: `./data/.flowise` (SQLite DB, logs, uploads)
- Qdrant data: `./data/qdrant` (vector DB storage)
- Both are volume-mounted for persistence and are ignored by git.

docker compose down
docker stop flowise qdrant-server
docker rm flowise qdrant-server
## Stopping & Cleaning Up
To stop and remove both Flowise and Qdrant containers, run:
```bash
bash .devcontainer/stop.sh
```

## Troubleshooting
- If you see port conflicts, make sure no other Flowise or Qdrant containers are running.
- If you see dependency errors, try pulling the latest images or reinstalling dependencies.

---

docker rm -f qdrant-server 2>/dev/null || true



