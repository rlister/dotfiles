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

# alias av='aws-vault exec'
alias et="emacsclient -t -a '' $*"
alias ec="emacsclient    -a '' $*"

## run stax from correct location
function s() {
  (
    cd $(git rev-parse --show-toplevel)/ops;
    bundle exec stax $*
  )
}

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
alias gpsu="git push --set-upstream origin $(git symbolic-ref --short HEAD)"
alias gss='git status -s'
alias gu='git pull --rebase --autostash' # see https://github.com/aanand/git-up
# alias gph='git push -u heroku master'
# alias gpo='git push origin master'
alias sha='git rev-parse HEAD'

alias tf='terraform'

function gil() {
  rm -f "$(git rev-parse --show-toplevel)/.git/index.lock"
}

## restart macos video daemon
alias video='sudo killall VDCAssistant'

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

## use as e.g. fl ops <cmd>
fl () {
  n=$[RANDOM % 3 + 1]
  sg=$argv[1]-ssh
  [[ "$argv[1]" -regex-match "\." ]] || argv[1]=$argv[1]-e${n}.spree.fm
  let-me-in ${sg} -- fleetctl -ssh-timeout=60 -tunnel $argv
}

off () { for x in $*; do; mv $x _$x; done }
on  () { for x in $*; do; mv $x `echo $x|sed -e 's/^_//'`; done }

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

# proxy () {
#   server=user@1.2.3.4
#   port=2223
#   case "$1" in
#     setup)
#       sudo networksetup -setsocksfirewallproxy 'Wi-Fi' localhost $port ;;
#     on)
#       sudo networksetup -setsocksfirewallproxystate 'Wi-Fi' on ;;
#     off)
#       sudo networksetup -setsocksfirewallproxystate 'Wi-Fi' off ;;
#     state)
#       sudo networksetup -getsocksfirewallproxy 'Wi-Fi' ;;
#     tunnel)
#       ssh -v -D ${port} -N ${server} ;;
#     ip)
#       curl --socks5 localhost:${port} http://smart-ip.net/myip ;;
#     *)
#       echo "usage: proxy setup|on|off|state|tunnel|ip"
#   esac
# }

## fzf chruby
# function cr() {
#   if (( $# > 0 )); then
#     chruby $*
#   else
#     local rb
#     rb=$(/bin/ls ${HOME}/.rubies | fzf-tmux --tac) \
  #       && chruby $rb
#   fi
# }

## convert flac to m4a (apple lossless) for itunes import
## needs ffmpeg from homebrew
function flac2m4a() {
  for f in $*; ffmpeg -i "$f" -c:a alac "${f%.*}.m4a"
}

function tell-emacs() {
  osascript -e 'tell application "Emacs" to activate'
}

function tell-iterm2() {
  osascript -e 'tell application "iTerm2" to activate'
}