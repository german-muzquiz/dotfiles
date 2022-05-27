#!/bin/bash

# Video: https://www.youtube.com/watch?v=uvvoJU69uNo

XFCE4_ROOT=$HOME/.config/xfce4
DOWNLOADS_ROOT=$XFCE4_ROOT/downloads

# Copy files
cd ..
cp -R * $HOME/.config/

# Install packages
sudo aptitude install gtk2-engines-murrine sassc git xfce4-appmenu-plugin xfce4-weather-plugin plank rofi python3-pyinotify gir1.2-webkit2-4.0 python3-levenshtein python3-websocket python3-xdg curl conky jq

xfconf-query -c xsettings -p /Gtk/ShellShowsMenubar -n -t bool -s true
xfconf-query -c xsettings -p /Gtk/ShellShowsAppmenu -n -t bool -s true

# Download resources
cd $DOWNLOADS_ROOT
git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git
git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git
git clone https://github.com/vinceliuice/WhiteSur-cursors.git
curl https://www.opencode.net/lsteam/xfce-big-sur-setup-file/-/raw/master/update-xfce-bigsur.zip -o update-xfce-bigsur.zip
unzip update-xfce-bigsur.zip

# Copy bundled files
cd $DOWNLOADS_ROOT/update-xfce-bigsur
mkdir -p $XFCE4_ROOT/wallpapers
cp -R wallpapers/* $XFCE4_ROOT/wallpapers/
mkdir -p $HOME/.fonts
cp -R fonts/* $HOME/.fonts/
mkdir -p $HOME/.local/share/icons
cp -R icons/* $HOME/.local/share/icons/
cp -R rofi $HOME/.config
mkdir -p $HOME/.config/ulauncher
cp -R ulauncher\ theme/* $HOME/.config/ulauncher
mkdir -p $HOME/.conky
cp -R conky/* $HOME/.conky/
cd $DOWNLOADS_ROOT
mkdir -p $HOME/.local/share/applications
cp applications/* $HOME/.local/share/applications
mkdir -p $HOME/.config/menu
cp xpple.menu $HOME/.config/menu/
mkdir -p $HOME/.local/share/plank/themes
cp -R WhiteSur-gtk-theme/src/other/plank/themes/* $HOME/.local/share/plank


# Install github packages
cd $DOWNLOADS_ROOT/WhiteSur-gtk-theme
./install.sh -c Light -c Dark
xfce4-panel -r
cd $DOWNLOADS_ROOT/WhiteSur-icon-theme
./install.sh
cd $DOWNLOADS_ROOT/WhiteSur-cursors
./install.sh


