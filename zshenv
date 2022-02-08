## -*-shell-script-*-
## set env vars

## this should be installed in ~/etc/profile, make symlinks as follows:
## ~/.zshenv for zsh (unlike .zprofile, will source for non-login shells)
## ~/.profile for bash

## for some reason, echoing from this file will break emacs tramp
## logins, but is ok from e.g. .zshrc; need to figure out why
#echo 'Running profile $Revision: 1.7 $ ...'

case $(uname) in
  Linux)
    PATH="${HOME}/bin:${HOME}/.krew/bin:/usr/local/bin:/usr/bin"
    ## python local pip installs
    PATH=$PATH:$(python -m site --user-base)/bin
    export PATH
    ;;
  Darwin)
    PATH="${HOME}/bin:${PATH}:/usr/local/sbin:/usr/local/bin:/Library/TeX/texbin"
    export PATH
    ;;
esac

## for remote hosts
# export CMDLINE_EDITOR=emacs

## local
export EDITOR=emacsclient
# VISUAL=${EDITOR}
# FCEDIT=${EDITOR}
# export EDITOR VISUAL FCEDIT

export PAGER=less

# export JAVA_HOME=$(/usr/libexec/java_home)
export GOPATH=~/code/go

# if [ -f ~/.env ]; then
#   source ~/.env
# fi

## fix scrolling in firefox using libinput2 with gtk3
## see https://wiki.archlinux.org/index.php/Firefox/Tweaks#Pixel-perfect_trackpad_scrolling
export MOZ_USE_XINPUT2=1

## aws-vault
export AWS_VAULT_BACKEND=pass
export AWS_VAULT_PROMPT=terminal
export AWS_VAULT_PASS_PASSWORD_STORE_DIR=~/.cache/aws-vault
#export AWS_VAULT_PASS_PASSWORD_STORE_DIR=~/src/pass
#export AWS_VAULT_PASS_PREFIX=av/
export AWS_SESSION_TOKEN_TTL=12h
export AWS_CHAINED_SESSION_TOKEN_TTL=12h
export AWS_ASSUME_ROLE_TTL=12h
export AWS_FEDERATION_TOKEN_TTL=12h
## needed for pinentry-tty when aws-vault writes sessions to pass
export GPG_TTY=$(tty)

## need this for qt5 to read qt5ct config file
export QT_QPA_PLATFORMTHEME=qt5ct

source ~/.zsh/asdf.zsh
