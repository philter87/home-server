#!/bin/bash

# Update this script from git repository
git pull origin main

repos=("philter87/home-server")

echo ""
echo "Deploying repositories..."
echo ""

for repo in ${repos[@]}; do
  
  repo_url="git@github.com:$repo.git"
  echo "Deployting: $repo"
  
  # Create folder if missing
  if [ ! -d $repo ]; then
    mkdir -p "git_repositories/$repo"
  fi

  cd "git_repositories/$repo"

  # Clone repository if missing
  if [ ! -d ".git" ]; then
    git clone $repo_url .
  fi

  git_output=$(git pull origin main 2>&1)
  if [[ $git_output == *"Already up to date"* ]]; then
    echo "NOTHING CHANGED"
  else
    echo "Change detected"
    docker compose build web
    docker compose up --no-deps -d web
  fi
done