#!/bin/bash

## General stuff here
sudo apt update
sudo apt upgrade

## If this is a laptop and the OS is ubuntu then ususlly overheating occurs so we need TLP

# This is from: https://itsfoss.com/reduce-overheating-laptops-linux/
sudo add-apt-repository ppa:linrunner/tlp
sudo apt-get update
sudo apt-get install tlp tlp-rdw
# If you are using ThinkPads, you require an additional step:
# sudo apt-get install tp-smapi-dkms acpi-call-dkms
#To uninstall TLP, you can use the following commands:
#sudo apt-get remove tlp
#sudo add-apt-repository --remove ppa:linrunner/tlp

# python stuff install pip
sudo apt install python3-pip
#installing required packages throgh pip
pip install ase

# Installing git and setting user data
sudo apt install git-all
git config --global user.name <github userID>
git config --global user.email johndoe@hotmail.com

# pulling my own repos
