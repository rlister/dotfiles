# -*- mode: shell-script; -*-

export QT_QPA_PLATFORMTHEME=qt6ct

xset b off

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
