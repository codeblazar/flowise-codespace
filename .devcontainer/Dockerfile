FROM node:20

# Install Python and curl
RUN apt update && apt install -y python3 python3-pip curl

# Install Chroma CLI and Python client
RUN pip3 install chromadb
RUN npm install -g chroma-cli

# Install Flowise
RUN npm install -g flowise@3.0.0

WORKDIR /workspace

# Copy config and start script (build context set to repo root)
COPY ../flowise.json .
COPY ../start.sh .
RUN chmod +x ./start.sh

# Expose ports for Flowise and Chroma
EXPOSE 7860 8000

# Launch startup script
CMD ["./start.sh"]