#!/bin/bash
set -e

# Resolve GITVISTA_HOME robustly
GITVISTA_HOME="$(cd "$(dirname "$(realpath "${BASH_SOURCE[0]:-$0}")")" && pwd)"

# 📌 Debug info
echo "📂 CURRENT REPO DIR: $(pwd)"
echo "🔗 SCRIPT PATH: $0"
echo "💡 GITVISTA_HOME resolved to: $GITVISTA_HOME"

# If version flag, print version and exit
if [[ "$1" == "--version" ]]; then
  echo "🚀 GIT VISTA - Interactive Git Tool v1.0.0"
  exit 0
fi

# Clear screen
clear

# ✅ Source entry point safely
source "$GITVISTA_HOME/git_intro.sh"

# ✅ Run the menu
load_api_key
git_vista
