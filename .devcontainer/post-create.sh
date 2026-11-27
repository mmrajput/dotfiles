#!/bin/bash
# Post-create script — runs once after container is created

set -e

# Terraform provider cache lives under ~/.config so it persists via the ~/.config host mount
mkdir -p "$HOME/.config/terraform/plugin-cache"

echo "✅ DevContainer ready. Repos available at /workspaces"
echo ""
echo "First time on this machine? Run:"
echo "  az login                   — authenticate to Azure"
echo "  gh auth login              — authenticate to GitHub"
