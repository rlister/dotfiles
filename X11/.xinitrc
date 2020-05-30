## desktop background
# ~/.fehbg

## settings daemons
xfsettingsd &
xfce4-power-manager  # brightness controls

## xsetroot does not work with compton
hsetroot -solid black
## sane trackball settings
xinput --set-prop 10 'libinput Accel Profile Enabled' 0, 1
xset r rate 200 25

# xcape -e 'Control_L=Escape'

## set my keyboard model
setxkbmap -model kinesis

## map modifiers eg menu to hyper
xmodmap ~/.xmodmap

## bind media keys etc
xbindkeys

## xterm settings
xrdb ~/.Xresources

## daemons
picom &
unclutter -noevents -root &
redshift -l 38.83039:-77.19637 &
/usr/lib/xfce4/notifyd/xfce4-notifyd & # notification daemon

## window manager
dwmstatus &
exec dwm
