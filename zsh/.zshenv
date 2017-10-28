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
    PATH="${HOME}/bin:/opt/bin:/opt/ruby/bin:/usr/local/bin:/bin:/usr/bin:/usr/bin/perlbin/core:/usr/X11R6/bin:/usr/games:/usr/sbin:/sbin"
    export PATH
    ;;
  Darwin)
    PATH="${HOME}/bin:${PATH}:/usr/local/sbin:/usr/local/bin:/opt/local/bin:${HOME}/local/node/bin:/usr/local/opt/go/libexec/bin"
    export PATH
    ;;
esac

## for remote hosts
# export CMDLINE_EDITOR=emacs

## local
# EDITOR=e
# VISUAL=${EDITOR}
# FCEDIT=${EDITOR}
# export EDITOR VISUAL FCEDIT

export JAVA_HOME=$(/usr/libexec/java_home)
export GOPATH=~/code/go

if [ -f ~/.env ]; then
  source ~/.env
fi