#!/bin/bash

## General stuff here
sudo apt update
sudo apt upgrade -y
# Adding commonly required packages
sudo apt install -y curl
sudo apt install -y texlive-latex-extra
sudo snap install --classic code
code --install-extension james-yu.latex-workshop
code --install-extension ms-python.python
sudo apt install -y gnuplot
curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add - 
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt install -y spotify-client

# Appearance and look and feel here
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 12

## If this is a laptop and the OS is ubuntu then usually overheating occurs so we need TLP
# This is from: https://itsfoss.com/reduce-overheating-laptops-linux/
sudo add-apt-repository ppa:linrunner/tlp
sudo apt-get update
sudo apt-get install -y tlp tlp-rdw
# If you are using ThinkPads, you require an additional step:
# sudo apt-get install tp-smapi-dkms acpi-call-dkms
#To uninstall TLP, you can use the following commands:
#sudo apt-get remove tlp
#sudo add-apt-repository --remove ppa:linrunner/tlp

# python stuff (setup and install of packages for me) 
# install pip
sudo apt install -y python3-pip
#installing required packages throgh pip
pip3 install ase

# Installing git and setting user data
sudo apt install -y git-all
git config --global user.name ebkera
git config --global user.email johndoe@hotmail.comg.org/mactex/elcapitan.html
How to install

# pulling my own repos and config files
path_to_packages=$(python3 -m site --user-site)
echo "Path to python packages: $path_to_packages"
echo "git cloning my repos..."
cd $path_to_packages
git clone https://github.com/ebkera/ebk.git 
# carbon ssh config file and settings
wget -O ~/.ssh/config https://raw.githubusercontent.com/ebkera/initialize_linux/main/config_ssh_carbon
read -p "Enter user name for ANL: " varname
sed -i "s|uname|${varname}|g" ~/.ssh/config

# Installing MS-teams (not in repos)
echo "Installing MS-Teams"
echo "If installation fails make sure you have curl installed... try sudo apt install curl"
curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/ms-teams stable main" > /etc/apt/sources.list.d/teams.list'
sudo apt update
sudo apt install -y teams
