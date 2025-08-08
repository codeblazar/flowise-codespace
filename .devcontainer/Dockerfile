FROM node:20

# Install system deps
RUN apt update && \
    apt install -y python3 python3-pip curl git && \
    pip3 install chromadb

# Install CLIs
RUN npm install -g chroma-cli@latest flowise@3.0.0 concurrently

# Create persistent data directory
RUN mkdir -p /data/chroma /data/flowise
WORKDIR /workspace

# Copy local config + startup script
COPY start.sh flowise.json ./
RUN chmod +x start.sh

# Expose both service ports
EXPOSE 8000 7860

# Launch both with concurrency manager
CMD ["concurrently", "bash start.sh"]