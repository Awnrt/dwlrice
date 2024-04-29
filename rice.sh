WORKDIRECTORY=$PWD
PERMUSER="awy"

sudo -u $PERMUSER mkdir -p /home/$PERMUSER/.local/bin/
sudo -u $PERMUSER cp -r $WORKDIRECTORY/scripts /home/$PERMUSER/.local/bin 

pacman -Sy --noconfirm
pacman -S artix-archlinux-support --noconfirm
echo "[extra]" >> /etc/pacman.conf
echo "Include = /etc/pacman.d/mirrorlist-arch" >> /etc/pacman.conf

cp /usr/include/pixman-1/* /usr/include/

DEPLIST="`sed -e 's/#.*$//' -e '/^$/d' dependencies.txt | tr '\n' ' '`"
pacman -Sy --noconfirm
pacman -S $DEPLIST --noconfirm

cd /home/$PERMUSER

sudo -u $PERMUSER git clone https://github.com/awnrt/dwl
sudo -u $PERMUSER git clone https://github.com/awnrt/dwlb
sudo -u $PERMUSER git clone https://github.com/awnrt/someblocks

cd dwl
make clean install
cd ..
cd dwlb
make clean install
cd ..
cd someblocks
make clean install
cd ..


pacman -Rdd elogind-dinit --noconfirm
pacman -S seatd-dinit --noconfirm
dinitctl enable seatd
usermod -aG seat $PERMUSER

echo "[ -x /usr/bin/fish ] && SHELL=/usr/bin/fish exec fish" >> /home/$PERMUSER/.bashrc

sudo -u $PERMUSER mkdir -p /home/$PERMUSER/.config/fish
sudo -u $PERMUSER cp $WORKDIRECTORY/config/config.fish /home/$PERMUSER/.config/fish/
sudo -u $PERMUSER mkdir -p /home/$PERMUSER/.config/foot
sudo -u $PERMUSER cp $WORKDIRECTORY/config/foot.ini /home/$PERMUSER/.config/foot/

