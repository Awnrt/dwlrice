echo "[ -x /usr/bin/fish ] && SHELL=/usr/bin/fish exec fish" >> /home/awy/.bashrc
[ "$(tty)" = "/dev/tty1" ] && ! pidof -s dwl >/dev/null 2>&1 && exec "dwl-startup"
