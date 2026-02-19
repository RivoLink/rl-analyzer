#!/usr/bin/env bash

set -e

REPO_URL="https://github.com/RivoLink/rl-analyzer.git"

# Parse argument
case "$1" in
  --claude)
    TARGET_DIR=".claude/commands/rl-analyzer"
    ;;
  --codex)
    TARGET_DIR=".agent/commands/rl-analyzer"
    ;;
  *)
    echo "Usage: $0 --claude | --codex"
    exit 1
    ;;
esac

echo "Creating target directory..."
mkdir -p "$TARGET_DIR"
cd "$TARGET_DIR"

echo "Cloning repository..."
git clone "$REPO_URL" .

echo "Removing git metadata..."
rm -rf .git

echo "Keeping only markdown files..."
find . -type f ! -name "*.md" -delete

echo "Moving command markdown files to root..."
if [ -d "commands" ]; then
  mv commands/*.md . 2>/dev/null || true
fi

echo "Cleaning empty directories..."
find . -type d -empty -delete

echo "Done"
