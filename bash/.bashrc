#! /bin/sh

## I've seen borked umasks on some adms, so fix that
umask 0022

## fix backspace (^H bad in emacs)
stty erase ^?

## get rid of vi bindings
set editing-mode emacs

## I want to set term to xterm so I get colours
if [ "$TERM" == "screen" ] ; then
  TERM=xterm
  export TERM
fi

## colours (\[...\] marks non-printing chars so spacing isn't messed up)
norm='\[\033[0;0m\]'
green='\[\033[0;32m\]'
yellow='\[\033[0;33m\]'
blue='\[\033[0;34m\]'
cyan='\[\033[0;36m\]'

## set prompt for interactive shells
if [ "$PS1" ]; then
    case $TERM in
	screen|xterm*)

	  ## set xterm title
	  PROMPT_COMMAND='echo -ne "\033]0;${HOSTNAME}[${USER}]: ${PWD}\007"'

	  ## set prompt
	  PS1="$blue[\t]$cyan\h$green \w\$$norm "
	  ;;
	*)
	  PS1='\u@\h \W\\$ '
	  ;;
    esac
fi

## clean up colour vars
unset norm cyan green yellow

## aliases
alias ctt='/sapi/production/component_test_tool.d/ctt.pl'
alias e='emacs -nw'
alias fl='cd $_' ## cd to last arg of last command
alias m='less'
alias ls='ls -hF'
alias ll='ls -Fl'
alias lo='ls -Fltr'
alias ta='type -a'
alias sa='sudo -u sapiadm'

## git laziness
alias ga='git add'
alias gb='git branch'
alias gc='git commit'
alias gca='git commit -a'
alias gcm='git commit -m'
alias gcam='git commit -am'
alias gco='git checkout'
alias gd='git diff'
alias gf='git fetch'
alias gm='git merge'
alias gp='git push'
alias gss='git status -s'

## toggle leading '_' in filename(s)
function off () { for x in $* ; do mv $x _$x; done }
function on  () { for x in $* ; do mv $x `echo $x|sed -e 's/^_//'`; done }

## use GNU ls options if on linux adm
if [ `uname` == "Linux" ] ; then
  #eval `dircolors ~/.dir_colors`
  alias ll='ls -lhF --color=tty'
  alias lo='ls -ltrhF --color=tty'
  alias ls='ls -F --color=tty'
fi

## explicitly use gnu ls on Sun jump hosts
if  [ `uname` == "SunOS" ] ; then
  eval `/opt/bcs/bin/dircolors ~/.dir_colors`
  alias ll='/opt/bcs/bin/ls -lhF --color=tty'
  alias lo='/opt/bcs/bin/ls -ltrhF --color=tty'
  alias ls='/opt/bcs/bin/ls -F --color=tty'
fi

## ssh-alikes complete my favourite hostnames
#aolhosts=$(cat ~/hosts/{tb,eutb,rspd,wlcdn,logpull,cargo,dw,feedback} | xargs)
# aolhosts=$(cat ~/hosts/* | xargs)
# complete -o nospace -A file -W "$aolhosts" ssh scp sr sa

## hcmcomposer complete pkgs with search in name and cmdline options
# hcmpkgs=$(/bin/ls /hcm/production/|fgrep search|xargs -i basename {} .d)
# hcmopts=$(hcmcomposer --help 2>&1 |grep " -[a-z]"|cut -d' ' -f5|xargs)
# complete -W "$hcmopts $hcmpkgs" hcmcomposer

## complete TB hosts for tbpush script
# tbhosts=$(cat ~/hosts/tb | xargs)
# complete -W "$tbhosts" tbpush.pl

## cmdline CTT complete options and project IDs
function _cttcomp () {
  local cttdir='/sapi/production/component_test_tool.d'

  ## these variables are global, to cache results on first run
  if [ -z "$cttproj" ] ; then
    cttproj=$(${cttdir}/ctt.pl -l|xargs)
  fi
  if [ -z "$cttopts" ] ; then
    cttopts=$(${cttdir}/ctt.pl -h 2>&1|grep "  -[a-z]"|cut -d' ' -f5|xargs)
  fi

  local word=${COMP_WORDS[COMP_CWORD]}
  COMPREPLY=($(compgen -W "$cttproj $cttopts" -- "${word}"))
}

complete -F _cttcomp ctt.pl ctt

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

function _augcomp () {
  augcfgs=$(aug -l|xargs)
  local word=${COMP_WORDS[COMP_CWORD]}
  COMPREPLY=($(compgen -W "$augcfgs" -- "${word}"))
}
complete -F _augcomp aug