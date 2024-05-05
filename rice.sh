WORKDIRECTORY=$PWD
PERMUSER="awy"

if [ "$EUID" -ne 0 ]
  then printf "The script has to be run as root.\n"
  exit
fi

sudo -u $PERMUSER mkdir -p /home/$PERMUSER/.local/bin/
sudo -u $PERMUSER cp -r $WORKDIRECTORY/scripts /home/$PERMUSER/.local/bin 

pacman -Sy --noconfirm
pacman -S artix-archlinux-support --noconfirm
echo "[extra]" >> /etc/pacman.conf
echo "Include = /etc/pacman.d/mirrorlist-arch" >> /etc/pacman.conf

#cp /usr/include/pixman-1/* /usr/include/

DEPLIST="`sed -e 's/#.*$//' -e '/^$/d' dependencies.txt | tr '\n' ' '`"
pacman -Sy --noconfirm
pacman -S $DEPLIST --noconfirm

cd /home/$PERMUSER

sudo -u $PERMUSER git clone https://github.com/awnrt/dwl
#sudo -u $PERMUSER git clone https://github.com/awnrt/dwlb
sudo -u $PERMUSER git clone https://github.com/awnrt/somebar
sudo -u $PERMUSER git clone https://github.com/awnrt/someblocks

cd dwl
make clean install
cd ..
#cd dwlb
#make clean install
cd somebar
sudo -u $PERMUSER meson setup build
sudo -u $PERMUSER ninja -C build
ninja -C build install
cd ..
cd someblocks
make clean install
cd ..


pacman -Rdd elogind-dinit --noconfirm
pacman -S seatd-dinit --noconfirm
dinitctl enable seatd
usermod -aG seat $PERMUSER

dinitctl enable dbus

echo "[ -x /usr/bin/fish ] && SHELL=/usr/bin/fish exec fish" >> /home/$PERMUSER/.bashrc

sudo -u $PERMUSER mkdir -p /home/$PERMUSER/.config/fish
sudo -u $PERMUSER cp $WORKDIRECTORY/config/config.fish /home/$PERMUSER/.config/fish/
sudo -u $PERMUSER mkdir -p /home/$PERMUSER/.config/foot
sudo -u $PERMUSER cp $WORKDIRECTORY/config/foot.ini /home/$PERMUSER/.config/foot/

sudo -u $PERMUSER mkdir -p /home/$PERMUSER/.local/share/papes
sudo -u $PERMUSER cp $WORKDIRECTORY/papes/* /home/$PERMUSER/.local/share/papes

echo "permit nopass :wheel" >> /etc/doas.conf
echo "permit nopass keepenv :$PERMUSER" >> /etc/doas.conf
echo "permit nopass keepenv :root" >> /etc/doas.conf

cd /home/$PERMUSER

sudo -u $PERMUSER mkdir -p /home/$PERMUSER/.local/share/themes
#sudo -u $PERMUSER mkdir -p /home/$PERMUSER/.local/share/icons
cd /home/$PERMUSER/.local/share/themes
sudo -u $PERMUSER curl -L "https://github.com/catppuccin/gtk/releases/download/v0.7.4/Catppuccin-Mocha-Standard-Lavender-Dark.zip" -o catppuccin.zip
sudo -u $PERMUSER unzip catppuccin.zip
rm catppuccin.zip

#cd /home/$PERMUSER/.local/share/icons
#sudo -u $PERMUSER curl -L "https://github.com/dracula/gtk/files/5214870/Dracula.zip" -o Dracula.zip
#sudo -u $PERMUSER unzip Dracula.zip
#rm Dracula.zip

#gsettings set org.gnome.desktop.interface gtk-theme "Dracula"
#gsettings set org.gnome.desktop.wm.preferences theme "Dracula"
#gsettings set org.gnome.desktop.interface icon-theme "Dracula"
