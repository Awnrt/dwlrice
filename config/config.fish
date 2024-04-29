if status is-interactive
    # Commands to run in interactive sessions can go here
    [ "$(tty)" = "/dev/tty1" ] && ! pidof -s dwl >/dev/null 2>&1 && exec "/home/awy/.local/bin/scripts/dwl-startup"
end
