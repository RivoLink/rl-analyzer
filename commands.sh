#!/usr/bin/env bash

set -e

REPO_URL="https://github.com/RivoLink/rl-analyzer.git"
TARGET_DIR=".claude/commands/rl-analyzer"

echo "Creating target directory"
mkdir -p "$TARGET_DIR"
cd "$TARGET_DIR"

echo "Cloning repository"
git clone "$REPO_URL" .

echo "Removing git metadata"
rm -rf .git

echo "Removing everything except commands/"
find . -mindepth 1 -maxdepth 1 ! -name "commands" -exec rm -rf {} +

echo "Moving command markdown files to root"
if [ -d "commands" ]; then
  mv commands/*.md . 2>/dev/null || true
fi

echo "Cleaning empty directories"
find . -type d -empty -delete

echo "Done"
