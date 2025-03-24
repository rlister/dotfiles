# -*- mode: shell-script; -*-

export QT_QPA_PLATFORMTHEME=qt6ct

xset b off

xrdb ~/.Xresources
xsettingsd &
unclutter -noevents -root &
# redshift &
CM_SELECTIONS=clipboard clipmenud &
dwmstatus &
sxhkd &

eval $(ssh-agent)
ssh-add ~/.ssh/id_ed25519

test -S "$XDG_RUNTIME_DIR/emacs/server" || emacs --daemon

exec "${WM:-dwm}"

pkill clipmenud
