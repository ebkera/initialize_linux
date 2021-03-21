#!/bin/bash

STARTTIME=$(date +%s)

## General stuff here
echo "################        Installation Log        ###############" > ~/installation.log
echo "Eranjan" >> ~/installation.log
echo "" >> ~/installation.log

BIN_DIR=$HOME/bin
CUR_DIR=($pwd)
INS_DIR=/opt
DEB_DIR=$HOME/debs

if [ ! -d $BIN_DIR ] 
then
    mkdir $BIN_DIR
    echo "  Directory $BIN_DIR did not exist and was created..." >> ~/installation.log
fi
echo "  Find your own binaries, executables and scripts in $BIN_DIR" >> ~/installation.log

if [ ! -d $INS_DIR ] 
then
    mkdir $INS_DIR
    echo "  Directory $INS_DIR did not exist and was created..." >> ~/installation.log
fi
echo "  Find  installed apps in $INS_DIR" >> ~/installation.log

if [ ! -d $DEB_DIR ] 
then
    mkdir $DEB_DIR
    echo "  Directory $DEB_DIR did not exist and was created..." >> ~/installation.log
fi
echo "  Find downloaded .debs in $DEB_DIR" >> ~/installation.log

gnome-terminal -- sh -c "tail -f ~/installation.log" 
echo "" >> ~/installation.log
echo "Maybe also do 'apt full-upgrade'... Not done here..." >> ~/installation.log
echo "" >> ~/installation.log
echo "Updating Repos" >> ~/installation.log
sudo apt update
echo "Upgrading Packages" >> ~/installation.log
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
echo "Installing etcher" >> ~/installation.log
echo "  -Adding Etcher’s repository to repo list" >> ~/installation.log
echo "deb https://deb.etcher.io stable etcher" | sudo tee /etc/apt/sources.list.d/balena-etcher.list
echo "  -Adding Etcher’s repository key to the trusted list" >> ~/installation.log
sudo apt-key adv --keyserver hkps://keyserver.ubuntu.com:443 --recv-keys 379CE192D401AB61
echo "  -Updating package list" >> ~/installation.log
sudo apt update
echo "  -Installing Etcher" >> ~/installation.log
sudo apt install -y balena-etcher-electron
# echo "Installing Okular (pdf reader)" >> ~/installation.log  # Not as good as I thought.
# sudo apt install -y okular
echo "Installing VESTA" >> ~/installation.log
echo "  -Downloading..." >> ~/installation.log
sudo mkdir $INS_DIR/VESTA
sudo wget https://jp-minerals.org/vesta/archives/3.5.7/VESTA-gtk3.tar.bz2 -O $INS_DIR/VESTA/VESTA-gtk3.tar.bz2
echo "  -Extracting" >> ~/installation.log
sudo tar -xvf $INS_DIR/VESTA/VESTA-gtk3.tar.bz2 -C $INS_DIR/VESTA/
echo "  -Cleaning up" >> ~/installation.log
sudo rm -f $INS_DIR/VESTA/VESTA-gtk3.tar.bz2
sudo ln -s $INS_DIR/VESTA/VESTA-gtk3/VESTA  $HOME/Desktop/VESTA
echo "  ==> Find the VESTA executable in $INS_DIR/VESTA/VESTA-gtk3/ .." >> ~/installation.log
echo "  ==> Find shortcut to VESTA on desktop" >> ~/installation.log
echo "Installing lm-sensors and hddtemp: monitor with sensors" >> ~/installation.log
sudo apt install -y lm-sensors hddtemp
echo "  More info at: https://itsfoss.com/check-laptop-cpu-temperature-ubuntu/" >> ~/installation.log
echo "Installing tkinter.. (matplotlib needs it to display)" >> ~/installation.log
sudo apt install -y python3-tk
echo "Installing Slack" >> ~/installation.log
echo "  -Downloading..." >> ~/installation.log
sudo wget https://downloads.slack-edge.com/linux_releases/slack-desktop-4.13.0-amd64.deb -O $DEB_DIR/slack-desktop-4.13.0-amd64.deb
echo "  -Installing" >> ~/installation.log
sudo apt install -y $DEB_DIR/slack-desktop-*.deb
# echo "  -Cleaning up" >> ~/installation.log
# sudo rm -f $DEB_DIR/slack-desktop-*.deb
echo "Installing VLC (snap since comes with codecs and updates)" >> ~/installation.log
sudo snap install vlc
echo "Installing dos2unix" >> ~/installation.log
sudo apt install -y dos2unix
echo "Installing flameshot for screenshots" >> ~/installation.log
sudo apt install -y flameshot
echo "Installing Zotero" >> ~/installation.log
echo "  -Downloading..." >> ~/installation.log
sudo mkdir $INS_DIR/zotero
sudo wget https://download.zotero.org/client/release/5.0.96/Zotero-5.0.96_linux-x86_64.tar.bz2 -O $INS_DIR/zotero/zotero.tar.bz2
echo "  -Extracting" >> ~/installation.log
sudo tar -xvf $INS_DIR/zotero/zotero.tar.bz2 -C $INS_DIR/zotero/
echo "  -Setting symlink to applications menu" >> ~/installation.log
sudo ln -s $INS_DIR/zotero/Zotero_linux-x86_64/zotero.desktop ~/.local/share/applications/zotero.desktop
echo "  -Cleaning up" >> ~/installation.log
sudo rm -r $INS_DIR/zotero/zotero.tar.bz2
echo "Installing Zoom" >> ~/installation.log
echo "  -Downloading..." >> ~/installation.log
sudo wget https://cdn.zoom.us/prod/5.5.7938.0228/zoom_amd64.deb -O $DEB_DIR/zoom_amd64.deb
echo "  -Installing..." >> ~/installation.log
sudo apt install -y $DEB_DIR/zoom_amd64.deb
echo "Installing BlueJeans" >> ~/installation.log
echo "  -Downloading..." >> ~/installation.log
sudo wget https://swdl.bluejeans.com/desktop-app/linux/2.21.2/BlueJeans_2.21.2.1.deb -O $DEB_DIR/bluejeans.deb
echo "  -Installing..." >> ~/installation.log
sudo apt install -y $DEB_DIR/bluejeans.deb
echo "Installing Geary" >> ~/installation.log
echo "  -Adding apt repo ppa:geary-team/releases..." >> ~/installation.log
sudo add-apt-repository -y ppa:geary-team/releases
echo "  -Installing" >> ~/installation.log
sudo apt install -y geary

# Installing vs-code from microsoft (non-snap) and extensions
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
echo "Installing vim extension for vs-code" >> ~/installation.log
code --install-extension vscodevim.vim

# Adding OBS since you will need it someday
echo "Installing OBS" >> ~/installation.log
sudo apt install -y ffmpeg
sudo add-apt-repository -y ppa:obsproject/obs-studio
sudo apt update  # updating new ppa
sudo apt install -y obs-studio

echo "Installing TeamViewer" >> ~/installation.log
echo "  -Downloading TeamViewer .deb 64bit" >> ~/installation.log
wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
echo "  -Installing TeamViewer .deb 64bit" >> ~/installation.log
sudo apt install -y ./teamviewer_amd64.deb

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

# Installing 4k video and 4k mp3 downloader
echo "Installing 4K video downloader" >> ~/installation.log
wget https://dl.4kdownload.com/app/4kvideodownloader_4.15.0-1_amd64.deb?source=website -O $DEB_DIR/4K_video.deb
sudo dpkg -i $DEB_DIR/4K_video.deb
echo "Installing 4K mp3 downloader" >> ~/installation.log
wget https://dl.4kdownload.com/app/4kyoutubetomp3_3.15.0-1_amd64.deb?source=website -O $DEB_DIR/4K_mp3.deb
sudo dpkg -i $DEB_DIR/4K_mp3.deb

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
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 16
echo "Setting text scalling factor to 0.8" >> ~/installation.log
gsettings set org.gnome.desktop.interface text-scaling-factor 0.9
echo "Setting custom Sri Lankan wallaper" >> ~/installation.log
wget -O ~/Downloads/wallpaper.jpg https://raw.githubusercontent.com/ebkera/initialize_linux/main/wp1857986-sri-lanka-wallpapers.jpg
# echo "Setting logo as wallaper" >> ~/installation.log
# wget -O ~/Downloads/wallpaper.jpg https://raw.githubusercontent.com/ebkera/initialize_linux/main/myLogo19Negative.png
# gsettings set org.gnome.desktop.background picture-uri file://$HOME/Downloads/wallpaper.jpg
echo "Adding my templates" >> ~/installation.log
echo "  -Bash Script" >> ~/installation.log
wget -O ~/Templates/New\ Bash\ Script.sh https://raw.githubusercontent.com/ebkera/initialize_linux/main/New%20Bash%20Script.sh
echo "  -Text Document" >> ~/installation.log
wget -O ~/Templates/Text\ Document.txt https://raw.githubusercontent.com/ebkera/initialize_linux/main/Text%20Document.txt


## If this is a laptop and the OS is ubuntu then usually overheating occurs so we need TLP
# This is from: https://itsfoss.com/reduce-overheating-laptops-linux/
echo "" >> ~/installation.log
echo "--Installing LTP for battery conservation on laptops--" >> ~/installation.log
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

# Scientific Software. Maybe edit this before running script to remove any you dont want.
echo "" >> ~/installation.log
echo "--Scientific Software--" >> ~/installation.log
echo "Installing vaspkit" >> ~/installation.log
echo "  -Downloading .deb file" >> ~/installation.log
sudo wget https://phoenixnap.dl.sourceforge.net/project/vaspkit/Binaries/vaspkit.1.2.5.Linux.x64.tar.gz -O $DEB_DIR/vaspkit.tgz
echo "  -Untaring into $INS_DIR/..." >> ~/installation.log
sudo tar -zxvf $DEB_DIR/vaspkit.tgz -C $INS_DIR
echo "  -Adding symbolic link to $BIN_DIR/..." >> ~/installation.log
sudo ln -s $INS_DIR/vasp*/bin/vaspkit $BIN_DIR/vaspkit
echo "  -Cleaning up" >> ~/installation.log
sudo rm -r -f $DEB_DIR/vaspkit.tgz


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
echo "  -git cloning -ebk-" >> ~/installation.log
git clone https://github.com/ebkera/ebk.git
echo "  -git cloning -thiruba-" >> ~/installation.log
git clone https://github.com/ebkera/thiruba.git
cd $CUR_DIR
echo "Getting script files" >> ~/installation.log
echo "  -Git cloning script files to $DEB_DIR/scripts" >> ~/installation.log
sudo git clone https://github.com/ebkera/scripts.git $DEB_DIR/scripts
echo "  -Copying nautilus script files to $HOME/.local/share/nautilus/scripts" >> ~/installation.log
sudo cp $DEB_DIR/scripts/nautilus_scripts/* $HOME/.local/share/nautilus/scripts/
sudo chmod +x -R $HOME/.local/share/nautilus/scripts/
echo "  -Copying bin script files to $BIN_DIR/scripts" >> ~/installation.log
sudo cp $DEB_DIR/scripts/bin_scripts/* $BIN_DIR/
sudo chmod +x -R $BIN_DIR/
echo "  -Cleaning up" >> ~/installation.log
sudo rm -r $DEB_DIR/scripts

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
echo "  -Starting OneDrive Personal" >> ~/installation.log
systemctl --user start onedrive
# Now let's do other Onedrives 
echo "Installing OneDrive Organizational" >> ~/installation.log
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
echo "  -Starting OneDrive Organizational" >> ~/installation.log
systemctl --user start onedrive_uic

echo "End of installing and updating." >> ~/installation.log
echo "" >> ~/installation.log
ENDTIME=$(date +%s)
time = $time=$(($ENDTIME - $STARTTIME))
echo "Installation walltime: $time seconds." >> ~/installation.log
echo "" >> ~/installation.log
echo "Ctrl+c to exit...." >> ~/installation.log

# Some useful commands
# To ender UEFI/BIOS
# systemctl reboot --firmware-setup
# To set lenovo conservation mode to on (1) and off (0)
# You have to login as root sudo su
# echo 0 > /sys/bus/platform/drivers/ideapad_acpi/VPC2004\:00/conservation_mode  # to set to conservation mode off
# tocheck secure boot status
# sudo mokutil --sb-state

