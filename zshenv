## -*-shell-script-*-

## .local/bin for pip install --user
export PATH="${HOME}/bin:${HOME}/.local/bin:/usr/local/bin:/usr/bin:${HOME}/go/bin"

## darwin
# PATH="${HOME}/bin:${PATH}:$(brew --prefix)/opt/coreutils/libexec/gnubin:/usr/local/sbin:/usr/local/bin:/Library/TeX/texbin"

## from zshrc?
# PATH="${HOME}/bin:${PATH}:/usr/local/sbin:/usr/local/bin:/opt/local/bin:${HOME}/local/node/bin:${HOME}/code/go/bin:/usr/local/opt/go/libexec/bin"

## for remote hosts
# export CMDLINE_EDITOR=emacs

export EDITOR=emacsclient
export PAGER=less
# export GOPATH=~/src/go

## fix scrolling in firefox using libinput2 with gtk3
## see https://wiki.archlinux.org/index.php/Firefox/Tweaks#Pixel-perfect_trackpad_scrolling
export MOZ_USE_XINPUT2=1

export GPG_TTY=$(tty) # needed for pinentry-tty when aws-vault writes sessions to pass
export SAML2AWS_KEYRING_BACKEND=pass

export QT_QPA_PLATFORMTHEME=qt5ct # for qt5 to read qt5ct config file

source /usr/share/chruby/chruby.sh
chruby 3.2.2
