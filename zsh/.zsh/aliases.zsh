case $(uname) in
  Linux)
    eval `dircolors ~/.dir_colors`
    LS='ls --color=tty'

    ## pasteboard commands: pacman -S xsel
    alias pbcopy='xsel --clipboard --input'
    alias pbpaste='xsel --clipboard --output'
    ;;

  Darwin)
    ## brew install coreutils
    if [ -x "$(which gdircolors)" ] ; then
      eval `gdircolors ~/.dir_colors`
      LS='gls --color=tty'
    else
      LS='ls -G'
    fi
    ;;
esac

alias ls="$LS -hF"
alias sl="$LS -hF"
alias ll="$LS -hFl"
alias la="$LS -hFla"
alias lo="$LS -hFltr"

## redshift will stomp on this
function brightness() {
  if [ -z "$1" ]; then
    xrandr --prop --verbose|grep Brightness
  else
    xrandr --output DP-1 --brightness "$1"
  fi
}

# alias av='aws-vault exec'
alias e="emacsclient -n"
alias et="emacsclient -t -a '' $*"
alias ec="emacsclient    -a '' $*"

alias be='bundle exec'
alias bi='bundle install'
alias bu='bundle update'

## git laziness
alias gb='git branch'
alias gco='git checkout'
alias gl="git log --branches --pretty='format:%C(blue)%h%Cblue%d%Creset %s %C(green) %an, %ar%Creset'"
alias gm='git merge'
alias gp='git push'
alias gu='git pull --rebase --autostash' # see https://github.com/aanand/git-up
alias sha='git rev-parse HEAD'

off () { for x in $*; do; mv $x _$x; done }
on  () { for x in $*; do; mv $x `echo $x|sed -e 's/^_//'`; done }

## http://www.suppertime.co.uk/blogmywiki/2015/04/updated-list-of-bbc-network-radio-urls/
alias bbc4='mplayer http://bbcmedia.ic.llnwd.net/stream/bbcmedia_radio4fm_mf_p'
alias bbc4lw='mplayer http://bbcmedia.ic.llnwd.net/stream/bbcmedia_radio4lw_mf_p'
alias bbc4ex='mplayer http://bbcmedia.ic.llnwd.net/stream/bbcmedia_radio4extra_mf_p'
alias bbc5='mplayer http://bbcmedia.ic.llnwd.net/stream/bbcmedia_radio5live_mf_p'
alias bbcw='mplayer http://bbcwssc.ic.llnwd.net/stream/bbcwssc_mp1_ws-eieuk'
alias bbcwn='mplayer http://bbcwssc.ic.llnwd.net/stream/bbcwssc_mp1_ws-einws'
alias bbcj='mplayer http://bbcmedia.ic.llnwd.net/stream/bbcmedia_lrjersey_mf_p'

gcalcol='--color-date=green --color-reader=blue --color-now-marker=yellow'
alias calh="gcalcli --config-folder ~/.gcalcli/home agenda $gcalcol"
alias calw="gcalcli --config-folder ~/.gcalcli/work agenda $gcalcol"

## docker cleanup
# stopall () {
#   docker stop $(docker ps -a -q)
# }

# rmall () {
#   docker stop $(docker ps -a -q)
#   docker rm   $(docker ps -a -q)
# }

# rmiall () {
#   docker stop $(docker ps -a -q)
#   docker rm   $(docker ps -a -q)
#   docker rmi  $(docker images -a -q)
# }

# rmiuntagged () {
#   docker rmi $(docker images | grep "^<none>" | awk '{print $3}')
# }

alias kc='kubectl'
alias kx='kubectx'
alias kn='kubens'
alias k9='TERM=xterm-256color k9s'
