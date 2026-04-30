#!/bin/bash
# Quick access script for homelab DevContainer
# Usage: dcs
#
# Starts the container if not running, then opens a login shell landing at /workspaces
# Container definition lives in dotfiles repo — independent of any project repo

set -e

# dotfiles repo is the canonical home for the container definition
DEVCONTAINER_ROOT="$HOME/dotfiles"

echo "🚀 Starting homelab DevContainer shell..."

# Check if devcontainer CLI is installed
if ! command -v devcontainer &> /dev/null; then
    echo "❌ Error: devcontainer CLI not found"
    echo ""
    echo "Install it with:"
    echo "  npm install -g @devcontainers/cli"
    exit 1
fi

# Start container if not already running
if ! devcontainer exec --workspace-folder "$DEVCONTAINER_ROOT" echo "test" &> /dev/null; then
    echo "📦 Container not running, starting it first..."
    devcontainer up --workspace-folder "$DEVCONTAINER_ROOT"
fi

# Resolve container name via devcontainer label
CONTAINER_NAME=$(docker ps \
    --filter "label=devcontainer.local_folder=$DEVCONTAINER_ROOT" \
    --format "{{.Names}}" | head -1)

if [ -z "$CONTAINER_NAME" ]; then
    echo "❌ Could not find running container"
    echo "   Try: devcontainer up --workspace-folder $DEVCONTAINER_ROOT"
    exit 1
fi

# Open login shell — sources ~/.bash_profile → ~/.bashrc → colored prompt
# Lands at /workspaces (WORKDIR set in Dockerfile)
echo "✅ Opening shell in DevContainer ($CONTAINER_NAME)..."
docker exec -it "$CONTAINER_NAME" bash -l
