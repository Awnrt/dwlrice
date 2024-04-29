WORKDIRECTORY = $PWD
PERMUSER = $USER
mkdir -p /home/$USER/.local/bin/
cp -r $PWD/scripts /home/$USER/.local/bin 

DEPLIST="`sed -e 's/#.*$//' -e '/^$/d' dependencies.txt | tr '\n' ' '`"
sudo pacman -Sy
sudo pacman -S $DEPLIST --noconfirm
