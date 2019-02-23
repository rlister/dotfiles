## clear all options
setxkbmap -model "pc101" -layout "us" -option ""

## capslock to ctrl
setxkbmap -rules "evdev" -model "pc101" -layout "us" -option "caps:ctrl_modifier"
