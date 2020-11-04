#!/bin/bash
# Remember to change email address for git on line 29

## General stuff here
sudo apt update
sudo apt upgrade
# Adding commonly required packages
sudo apt install curl

## If this is a laptop and the OS is ubuntu then usually overheating occurs so we need TLP
# This is from: https://itsfoss.com/reduce-overheating-laptops-linux/
sudo add-apt-repository ppa:linrunner/tlp
sudo apt-get update
sudo apt-get install tlp tlp-rdw
# If you are using ThinkPads, you require an additional step:
# sudo apt-get install tp-smapi-dkms acpi-call-dkms
#To uninstall TLP, you can use the following commands:
#sudo apt-get remove tlp
#sudo add-apt-repository --remove ppa:linrunner/tlp

# python stuff (setup and install of packages for me) 
# install pip
sudo apt install python3-pip
#installing required packages throgh pip
pip3 install ase

# Installing git and setting user data
sudo apt install git-all
git config --global user.name ebkera
git config --global user.email johndoe@hotmail.com

# pulling my own repos
path_to_packages=$(python3 -m site --user-site)
echo "Path to python packages: $path_to_packages"
echo "git cloning my repos..."
cd $path_to_packages
git clone https://github.com/ebkera/ebk.git

# Installing MS-teams (not in repos)
echo "Installing MS-Teams"
echo "If installation fails make sure you have curl installed... try sudo apt install curl"
curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/ms-teams stable main" > /etc/apt/sources.list.d/teams.list'
sudo apt update
sudo apt install teams
