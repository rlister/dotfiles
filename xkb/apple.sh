## clear all options
setxkbmap -model "pc105" -layout "hr,us" -option ""

## set the Apple keyboard
setxkbmap -rules "evdev" -model "pc105" -layout "hr,us" -option "terminate:ctrl_alt_bksp,lv3:rwin_switch,grp:shifts_toggle,caps:ctrl_modifier,altwin:swap_lalt_lwin"
