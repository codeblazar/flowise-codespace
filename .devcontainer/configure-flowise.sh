#!/bin/bash
set -e

ENV_FILE="$(dirname "$0")/.env"

read -p "Enter Flowise login email: " email
read -s -p "Enter Flowise password: " password
printf "\n"
read -s -p "Confirm password: " password2
printf "\n"

if [ "$password" != "$password2" ]; then
  echo "Passwords do not match. Aborting."
  exit 1
fi

# Remove existing lines for username and password
sed -i '/^FLOWISE_USERNAME=/d' "$ENV_FILE" 2>/dev/null || true
sed -i '/^FLOWISE_PASSWORD=/d' "$ENV_FILE" 2>/dev/null || true

# Add new credentials
{
  echo "FLOWISE_USERNAME=$email"
  echo "FLOWISE_PASSWORD=$password"
} >> "$ENV_FILE"

echo "[INFO] .env updated with new Flowise credentials."
