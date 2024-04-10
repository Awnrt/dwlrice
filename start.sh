export XDG_RUNTIME_DIR=/tmp/xdg-runtime-$(id -u)
mkdir -p $XDG_RUNTIME_DIR
#export WLR_RENDERER_ALLOW_SOFTWARE=1
#dwl -s 'dwlb -font "JetBrainsMonoNerdFontMono:size=12"'
someblocks -p | dwlb -status-stdin all &
dwl -s 'dwlb -font "JetBrainsMonoNerdFontMono:size=12"'

