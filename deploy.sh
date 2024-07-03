#!/bin/bash

script_path=$(realpath "$0")
script_dir=$(dirname "$script_path")
cd $script_dir

echo ""
echo "Deploying repositories..."
echo ""

jq -c '.[]' apps.json | while read app_json; do

    echo "Current directory: $script_dir"
    cd "$script_dir"
    echo "Current directory: $script_dir"

    # Get the value of the key
    repo=$(echo $app_json | jq -r '.repo')
    service_name=$(echo $app_json | jq -r '.serviceName')
    sub_folder=$(echo $app_json | jq -r '.subFolder')
    echo "Repo: $repo"

    repo_url="git@github.com:$repo.git"
    echo "Deploying: $repo"
    
    # Create folder if missing
    if [ ! -d $repo ]; then
      mkdir -p "apps/$repo"
    fi

    cd "apps/$repo"
    echo "Current directory: $(pwd)"

    # Clone repository if missing
    if [ ! -d ".git" ]; then
      echo "New repo detected: $repo_url"
      git clone $repo_url .

      cd $sub_folder
      docker-compose up -d
      
      continue
    fi
    
    git_output=$(git pull origin main 2>&1)
    if [[ $git_output == *"Already up to date"* ]]; then
    #if false ; then
      echo "NOTHING CHANGED"
    else
      echo "Change detected"
      
      cd $sub_folder
      docker compose build web
      docker compose up --no-deps -d web
    fi
done