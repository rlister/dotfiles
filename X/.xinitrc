## -*- mode: shell-script -*-
xrdb -load ${HOME}/etc/Xdefaults
xmodmap ${HOME}/etc/xmodmap
xset b off
unclutter &
xterm &
#ivman&
emacs --daemon&

## write conky to dwm status bar
#conky -c ${HOME}/etc/conkyrc | while true; read line; do xsetroot -display :0.0 -name "$line"; done &

## start window manager
#DISPLAY=:0.1 wmii -r ${HOME}/etc/wmii/wmiirc &
WM=openbox

DISPLAY=:0.1 ${WM} 2> ~/.${WM}.err1 &
while true; do DISPLAY=:0.0 ${WM} 2> ~/.${WM}.err0; done
