TARGETS := \
	~/.config/dunst/dunstrc \
	~/.config/k9s/views.yml \
	~/.config/picom.conf \
	~/.config/redshift.conf \
	~/.config/rofi/config.rasi \
	~/.dir_colors \
	~/.screenrc \
	~/.ssh/config \
	~/.themes \
	~/.xbindkeysrc \
	~/.xinitrc \
	~/.xmodmap \
	~/.Xresources \
	~/.zshenv \
	~/.zshrc

install: $(TARGETS)

check:
	@ls -ld $(TARGETS)

clean:
	@rm -fv $(TARGETS)

## simple dotfile in home directory
~/.%:
	@ln -sfvr $* $@

## nested config file in .config dir
~/.config/%:
	@mkdir -pv $(@D)
	@ln -sfvr $(PWD)/$* $@
