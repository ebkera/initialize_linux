#!/bin/bash

## General stuff here
echo "" >> ~/installation.log
echo "Installation Log" > ~/installation.log
# gnome-terminal -- tail -f ~/installation.log # Need to fix does not stay open # Will open up a new terminaland follow on .log file
echo "" >> ~/installation.log
echo "Updating Repos" >> ~/installation.log
sudo apt update
echo "Upgrading Repos" >> ~/installation.log
sudo apt upgrade -y

# Adding commonly required packages
echo "" >> ~/installation.log
echo "--Commonly required packages--" >> ~/installation.log
echo "Installing vim" >> ~/installation.log
sudo apt install -y vim
echo "Installing htop" >> ~/installation.log
sudo apt install -y htop
echo "Installing curl" >> ~/installation.log
sudo apt install -y curl
echo "Installing texlive-latex-extra" >> ~/installation.log
sudo apt install -y texlive-latex-extra
echo "Installing latexmk" >> ~/installation.log
sudo apt install -y latexmk  # this is for vscode extension latex-workshop
echo "Installing snapd" >> ~/installation.log
sudo apt install -y snapd
echo "Installing MS todo (unofficial)" >> ~/installation.log
sudo snap install microsoft-todo-unofficial
echo "Installing gnuplot" >> ~/installation.log
sudo apt install -y gnuplot
echo "Installing Spotify" >> ~/installation.log
curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add - 
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt install -y spotify-client

# Installing vs-code from microsoft (non-snap) and extenstions
echo "Installing vs-code (non-snap)" >> ~/installation.log
echo "  -wget-ing files..." >> ~/installation.log
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
echo "  -installing microsoft packages..." >> ~/installation.log
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
echo "  -updating package cache and installing..." >> ~/installation.log
sudo apt install apt-transport-https
sudo apt update
echo "  -installing vs-code..." >> ~/installation.log
sudo apt install -y code # or code-insiders
# vs-code (snap version, in case we will need it)
# echo "Installing vs-code (snap)" >> ~/installation.log
# sudo snap install --classic code
echo "Installing latex extension for vs-code" >> ~/installation.log
code --install-extension james-yu.latex-workshop
echo "Installing python extension for vs-code" >> ~/installation.log
code --install-extension ms-python.python

# Adding OBS since you will need it someday
echo "Installing OBS" >> ~/installation.log
sudo apt install -y ffmpeg
sudo add-apt-repository -y ppa:obsproject/obs-studio
sudo apt update  # updating new ppa
sudo apt install -y obs-studio

# Installing signal
echo "Installing Signal" >> ~/installation.log
# Installing snap package is below but we will use signals repos
# sudo snap install signal-desktop
# get the GPG key for the official Signal repository and add it to the trusted keys of your APT package manager.
wget -O- https://updates.signal.org/desktop/apt/keys.asc | sudo apt-key add -
# With the key added, you can safely add the repository to your system.
echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | sudo tee -a /etc/apt/sources.list.d/signal-xenial.list
# Thanks to the tee command in Linux, you’ll have a new file signal-xenial.list in the sources.list directory /etc/apt/sources.list.d. This new file will have the Signal repository information i.e. deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main.
# Now that you have added the repository, update the cache and install Signal desktop application
sudo apt update && sudo apt install -y signal-desktop  # Its essenstial to update again for the new repos.

# Installing MS-teams (not in repos)
echo "Installing Teams" >> ~/installation.log
echo "  If installation fails make sure you have curl installed... try sudo apt install curl" >> ~/installation.log
curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/ms-teams stable main" > /etc/apt/sources.list.d/teams.list'
sudo apt update
sudo apt install -y teams

# Installing Windscribe
echo "Installing Windscribe" >> ~/installation.log
echo "  More info at: https://windscribe.com/guides/linux" >> ~/installation.log
echo "  -Adding the Windscribe signing key to apt..." >> ~/installation.log
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key FDC247B7
echo "  -Adding repository to my sources.list..." >> ~/installation.log
echo 'deb https://repo.windscribe.com/ubuntu bionic main' | sudo tee /etc/apt/sources.list.d/windscribe-repo.list
echo "  -Running apt-get update " >> ~/installation.log
sudo apt-get update
echo "  -Installing windscribe-cli " >> ~/installation.log
sudo apt-get install -y windscribe-cli
# 6. Login to Windscribe
# windscribe login
# 7. Connect to Windscribe
# windscribe connect
# 8. Need help?
# windscribe --help

# Installing qbitbtorrent
https://www.fossmint.com/best-bittorrent-clients-for-linux/
echo "Installing qbitorrent" >> ~/installation.log
echo "  More info at: https://www.qbittorrent.org/" >> ~/installation.log
echo "  More installation info at: https://www.fossmint.com/best-bittorrent-clients-for-linux/" >> ~/installation.log
echo "  -Adding PPA" >> ~/installation.log
$ sudo add-apt-repository ppa:qbittorrent-team/qbittorrent-stable
echo "  -Updating repos" >> ~/installation.log
$ sudo apt-get update
echo "  -Installing qbittorrent" >> ~/installation.log
sudo apt-get install -y qbittorrent

# Appearance and look and feel here
echo "" >> ~/installation.log
echo "--Appearance/Look and feel--" >> ~/installation.log
echo "Setting dock to bottom" >> ~/installation.log
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM
echo "Changing Icon size to 12" >> ~/installation.log
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 12
echo "Setting text scalling factor to 0.8" >> ~/installation.log
gsettings set org.gnome.desktop.interface text-scaling-factor 0.8
echo "Setting custom Sri Lankan wallaper" >> ~/installation.log
wget -O ~/Downloads/wallpaper.jpg https://raw.githubusercontent.com/ebkera/initialize_linux/main/wp1857986-sri-lanka-wallpapers.jpg
# echo "Setting logo as wallaper" >> ~/installation.log
# wget -O ~/Downloads/wallpaper.jpg https://raw.githubusercontent.com/ebkera/initialize_linux/main/myLogo19Negative.png
gsettings set org.gnome.desktop.background picture-uri file://$HOME/Downloads/wallpaper.jpg

## If this is a laptop and the OS is ubuntu then usually overheating occurs so we need TLP
# This is from: https://itsfoss.com/reduce-overheating-laptops-linux/
echo "" >> ~/installation.log
echo "--Setting LTP for battery conservation on laptops--" >> ~/installation.log
echo "Adding PPA linrunner" >> ~/installation.log
sudo add-apt-repository -y ppa:linrunner/tlp
echo "Updating PPA" >> ~/installation.log
sudo apt-get update
echo "Installing LTP" >> ~/installation.log
sudo apt-get install -y tlp tlp-rdw
# If you are using ThinkPads, you require an additional step:
# sudo apt-get install tp-smapi-dkms acpi-call-dkms
#To uninstall TLP, you can use the following commands:
#sudo apt-get remove tlp
#sudo add-apt-repository --remove ppa:linrunner/tlp

# python stuff (setup and install of packages for me) 
echo "" >> ~/installation.log
echo "--Python/Github and setting up my git repos--" >> ~/installation.log
# install pip
echo "Installing pip" >> ~/installation.log
sudo apt install -y python3-pip
#installing required packages throgh pip
echo "Installing ASE" >> ~/installation.log
pip3 install ase

# From here down we have setups where user input is needed.
echo "" >> ~/installation.log
echo "--From here on prepare to input user data--" >> ~/installation.log
echo "" >> ~/installation.log
# Installing git and setting user data
echo "Installing git" >> ~/installation.log
sudo apt install -y git-all
git config --global user.name ebkera
echo "Enter git email on prompt..." >> ~/installation.log
read -p "Enter email for git: " gitemail
git config --global user.email $gitemail

# pulling my own repos and config files
echo "Pulling my own repos and config files" >> ~/installation.log
path_to_packages=$(python3 -m site --user-site)
echo "Path to python packages: $path_to_packages"
echo "Git cloning my repos" >> ~/installation.log
cd $path_to_packages
git clone https://github.com/ebkera/ebk.git 
# carbon ssh config file and settings
wget -O ~/.ssh/config https://raw.githubusercontent.com/ebkera/initialize_linux/main/config_ssh_carbon
echo "Enter username for ANL on prompt..." >> ~/installation.log
read -p "Enter user name for ANL: " varname
sed -i "s|uname|${varname}|g" ~/.ssh/config

# Installing onedrive
echo "" >> ~/installation.log
echo "--Installing OneDrive--" >> ~/installation.log
echo "Installing OneDrive personal" >> ~/installation.log
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
echo "Installing OneDrive Organization" >> ~/installation.log
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


