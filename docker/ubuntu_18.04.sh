#!/bin/bash

if [ $(id -u) = 0 ]; then
   echo "This script changes your user groups and should thus not be run as root!"
   echo "You may need to enter your password multiple times!"
   exit 1
fi

# Update package lists
sudo apt update

# install a few prerequisite packages which let apt use packages over HTTPS:
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

# add the GPG key for the official Docker repository to your system:
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Add the Docker repository to APT sources:
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"

# update the package database with the Docker packages from the newly added repo:
sudo apt update

# Finally, install Docker:
sudo apt install docker-ce

# Start the docker daemon and enable for start at boot
sudo systemctl start docker
sudo systemctl enable docker

# Add user to docker group so no sudo required
sudo usermod -aG docker ${USER}

#The user needs to reboot to apply all changes.
echo "Please Reboot" && exit 0
