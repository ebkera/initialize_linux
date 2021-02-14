#!/bin/bash

## General stuff here
sudo apt update
sudo apt upgrade -y
# Adding commonly required packages
sudo apt install -y curl
sudo apt install -y texlive-latex-extra
sudo apt install -y latexmk  # this is for vscode extension latex-workshop
sudo apt install -y snapd
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
gsettings set org.gnome.desktop.interface text-scaling-factor 0.8

## If this is a laptop and the OS is ubuntu then usually overheating occurs so we need TLP
# This is from: https://itsfoss.com/reduce-overheating-laptops-linux/
sudo add-apt-repository -y ppa:linrunner/tlp
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
read -p "Enter email for git: " gitemail
git config --global user.email $gitemail

# Installing MS-teams (not in repos)
echo "Installing MS-Teams"
echo "If installation fails make sure you have curl installed... try sudo apt install curl"
curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/ms-teams stable main" > /etc/apt/sources.list.d/teams.list'
sudo apt update
sudo apt install -y teams

#From here down we have setups where user input is needed.
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

# Installing onedrive
# See informative webpage here: https://www.linuxuprising.com/2020/02/how-to-keep-onedrive-in-sync-with.html
# See git repo we use here: https://github.com/abraunegg
# Do not use "apt intall onedrive" before installing the ppa as it is no longer supported and is not recommended.
sudo add-apt-repository -y ppa:yann1ck/onedrive
sudo apt install -y onedrive
# The below part is for the personal onedrive
onedrive  # Run onedrive to install for personal accounts. Copy the link shown and paste it in the web browser. Login and you will be taken to a blank page. Copy URL of page into terminal.
# The following two lines are uncommented because it will take time. The first line only checks. The second line syncs but will not be persistent. This might automatically happen during the enabling of services
# onedrive --synchronize --verbose --dry-run  # Dont really need this but checking to see if everything works.
# onedrive --synchronize # This will sync all the files.
# This will enable systemd services to automate the startup, syncing and monitoring of onedrive.
sudo apt install -y libnotify-dev  # Prereq for notifications
systemctl --user enable onedrive
systemctl --user start onedrive
# Now let's do other Onedrives 
# We follow instructions from here: https://github.com/abraunegg/onedrive/blob/master/docs/advanced-usage.md
mkdir ~/.config/onedrive_uic
# We should copy in a default config file. Here I have used a pre built config file.
wget https://raw.githubusercontent.com/ebkera/initialize_linux/main/config_UIC_Onedrive -O ~/.config/onedrive_uic/config
onedrive --confdir="~/.config/onedrive_uic"  # Here do the same as previous here: login with link, copy url back.
onedrive --confdir="~/.config/onedrive_uic" --display-config  # Using this we can display the current configuration. Make sure you do this. There was a mistake in the original file.
# The following two lines are uncommented because it will take time. The first line only checks. The second line syncs but will not be persistent. This might automatically happen during the enabling of services
# onedrive --confdir="~/.config/onedrive_uic" --synchronize --verbose --dry-run
# onedrive --confdir="~/.config/onedrive_uic" --synchronize --verbose
# Deviating a little bit from the instructions from onedrive. Instead of coyinbg a file and changing it I have already a set file that can be downloaded.
# This is the relevant command if you want to copy and change the file: sudo cp /usr/lib/systemd/user/onedrive.service /usr/lib/systemd/user/onedrive_uic.service
sudo wget https://raw.githubusercontent.com/ebkera/initialize_linux/main/onedrive_uic.service -O /usr/lib/systemd/user/onedrive_uic.service
systemctl --user enable onedrive_uic
systemctl --user start onedrive_uic


