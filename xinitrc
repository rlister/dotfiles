# -*- mode: shell-script; -*-

## xsetroot does not work with compton
hsetroot -solid black

## no beeps
xset b off

## settings daemons
xfsettingsd &
xfce4-power-manager --daemon  # brightness controls

## sane trackball settings
xinput --set-prop 10 'libinput Accel Profile Enabled' 0, 1
xset r rate 200 25

## set my keyboard model
setxkbmap -model kinesis
setxkbmap -option compose:menu

## bind media keys etc
xbindkeys

## xorg settings
xrdb ~/.Xresources

## daemons
picom &
unclutter -noevents -root &
redshift &
dunst &
CM_SELECTIONS=clipboard clipmenud &
dwmstatus &
emacs -bg-daemon
xscreensaver --no-splash &

## window manager
exec dwm

## cleanup
emacsclient -e '(kill-emacs)'
