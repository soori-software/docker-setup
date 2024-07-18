#!/bin/bash

source /etc/os-release

if [ "$ID" == "ubuntu" ]; then
  REPO_URL="https://download.docker.com/linux/ubuntu"
  CODENAME="$VERSION_CODENAME"
elif [ "$ID" == "debian" ]; then
  REPO_URL="https://download.docker.com/linux/debian"
  CODENAME="$VERSION_CODENAME"
else
  echo "Unsupported distribution: $ID"
  exit 1
fi

# Update the package index
sudo apt-get update

# Install required packages
sudo apt-get install -y ca-certificates curl

# Create the keyrings directory
sudo install -m 0755 -d /etc/apt/keyrings

# Add Docker's official GPG key
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the Docker repository to Apt sources
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo \"$VERSION_CODENAME\") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update the package index again
sudo apt-get update

# Install Docker packages
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Verify the Docker Engine installation
sudo docker run hello-world

# Output the Docker version to confirm installation
docker --version
