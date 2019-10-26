~/.fehbg
lxpolkit &
xfsettingsd &
xinput --set-prop 10 'libinput Accel Profile Enabled' 0, 1
xset r rate 200 25
# xcape -e 'Control_L=Escape'
xmodmap ~/.xmodmap
xbindkeys
xrdb ~/.Xresources
compton &
dunst &
unclutter -noevents -root &
redshift -l 38.83039:-77.19637 &
dwmstatus &
exec dwm
