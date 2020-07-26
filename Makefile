PKGS?=ls picom redshift rofi ruby ssh themes X11 xbindkeys zsh
DIR?=~

install:
	stow -v -t $(DIR) $(PKGS)

test:
	stow -v -n -t $(DIR) $(PKGS)

uninstall:
	stow -v -n -t $(DIR) -D $(PKGS)
