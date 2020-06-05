#!/bin/bash
. ./post_install_helper.sh
. ./post_install_general.sh
. ./post_install_code.sh
. ./post_install_i3.sh

echo "Updating and Upgrading"
sudo pacman -Syyu

installYay
installSnap

# install dialog if needed
installDialog

# setup variables
TEMP_DIR=~/setup-temp

mkdir -p $TEMP_DIR
mkdir -p ~/.config/autostart

#move to temp folder
cd $TEMP_DIR

askDialog

installGeneralChoice

installCodeChoice

installI3Choice
