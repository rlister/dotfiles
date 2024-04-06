# -*- mode: shell-script; -*-

## no beeps
xset b off

# xfce4-power-manager --daemon  # brightness controls
# /usr/lib/xdg-desktop-portal-gtk -r &

## sane trackball settings
xinput --set-prop 10 'libinput Accel Profile Enabled' 0, 1
xset r rate 200 25

## set my keyboard model
setxkbmap -model kinesis
setxkbmap -option compose:menu

## import DISPLAY to systemd user session
source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh

xrdb ~/.Xresources

xsettingsd &
picom &
unclutter -noevents -root &
redshift &
dunst &
CM_SELECTIONS=clipboard clipmenud &
dwmstatus &
xscreensaver --no-splash &
eval $(ssh-agent)
ssh-add ~/.ssh/id_ed25519
emacs --daemon

sxhkd &
exec "${WM:-dwm}"

## cleanup
emacsclient -e '(kill-emacs)'
