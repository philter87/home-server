#!/bin/bash

script_dir=$(dirname $0)

echo ""
echo "Deploying repositories..."
echo ""

jq -c '.[]' apps.json | while read app_json; do
    # Get the value of the key
    repo=$(echo $app_json | jq -r '.repo')
    service_name=$(echo $app_json | jq -r '.serviceName')
    sub_folder=$(echo $app_json | jq -r '.subFolder')
    echo "Repo: $repo"

    repo_url="git@github.com:$repo.git"
    echo "Deploying: $repo"
    
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
      cd $sub_folder
      # Docker compose up everything
      docker-compose --no-recreate -f docker-compose.yml -f docker-compose.prod.yml up -d 

      docker compose build web
      docker compose up -f docker-compose.yml -f docker-compose.prod.yml --no-deps -d web
    fi

    cd $script_dir
done