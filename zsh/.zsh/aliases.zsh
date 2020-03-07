case $(uname) in
  Linux)
    if [ -x "$(which dircolors)" ] ; then
      eval `dircolors ~/.dir_colors`
    fi
    LS='ls --color=tty'

    ## Mac-a-like pasteboard commands: pacman -S xsel
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

## run stax from correct location
function s() {
  (
    cd $(git rev-parse --show-toplevel)/ops;
    bundle exec stax $*
  )
}

# function s() {
#   pushd `git rev-parse --show-toplevel`/ops
#   bundle exec stax $*
#   popd
# }

alias ls="$LS -hF"
alias sl="$LS -hF"
alias ll="$LS -hFl"
alias la="$LS -hFla"
alias lo="$LS -hFltr"

alias lmi=let-me-in

alias be='bundle exec'
alias bi='bundle install'
alias bu='bundle update'

## git laziness
alias gb='git branch'
alias gca='git commit -a'
alias gcm='git commit -m'
alias gcam='git commit -am'
alias gco='git checkout'
alias gd='git diff'
alias gl="git log --branches --pretty='format:%C(blue)%h%Cblue%d%Creset %s %C(green) %an, %ar%Creset'"
alias gm='git merge'
alias gp='git push'
alias gss='git status -s'
alias gu='git pull --rebase --autostash' # see https://github.com/aanand/git-up
# alias gph='git push -u heroku master'
# alias gpo='git push origin master'
alias sha='git rev-parse HEAD'

alias tf='terraform'

## delete local branches that have gone from remote
function git-prune() {
  git checkout master
  git fetch --all -p
  git branch -vv | grep ": gone]" | awk  '{ print $1 }' | xargs -n 1 git branch -d
  git checkout -
}

## aws regions
alias e1='AWS_REGION=us-east-1'
alias w1='AWS_REGION=us-west-1'
alias w2='AWS_REGION=us-west-2'
alias s1='AWS_REGION=sa-east-1'

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
