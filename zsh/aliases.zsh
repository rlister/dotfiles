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
    if [ -x "$(which gdircolors)" ] ; then
      eval `gdircolors ~/.dir_colors`
      LS='gls --color=tty'
    else
      LS='ls -G'
    fi
    ;;
esac

alias ce='aws-vault exec'
alias et="emacsclient -t -a '' $*"
alias ec="emacsclient    -a '' $*"

function fd() {(cd ~/code/spreeworks/ops && bundle exec bin/fd $*)}
function ops() {(cd ~/code/ops && bundle exec bin/ops $*)}

## open current tmux pane in emacs
# alias l='f=/tmp/$(uuid) && tmux capture-pane -S 1 && tmux save-buffer $f && e $f && rm -f $f && unset f'

alias ls="$LS -hF"
alias sl="$LS -hF"
alias ll="$LS -hFl"
alias la="$LS -hFla"
alias lo="$LS -hFltr"

alias lmi=let-me-in

alias be='bundle exec'
alias bi='bundle install'
alias bu='bundle update'
# alias dm='docker-machine'
# function dmenv { eval "$(docker-machine env $1)" }

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
alias gu='git up'               # gem install git-up
# alias gph='git push -u heroku master'
# alias gpo='git push origin master'

## delete local branches that have gone from remote
function git-prune() {
  git checkout master
  git fetch --all -p
  git branch -vv | grep ": gone]" | awk  '{ print $1 }' | xargs -n 1 git branch -d
  git checkout -
}

## fzf checkout a branch or tag (just call git checkout if args are given)
# function gco() {
#   if (( $# > 0 )); then
#     git checkout $*
#   else
#     local tags branches target
#     tags=$(
#       git tag | awk '{print "\x1b[31mtag\x1b[m\t" $1}') || return
#     branches=$(
#       git branch --all | grep -v HEAD             |
#         sed "s/.* //"    | sed "s#remotes/[^/]*/##" |
#         sort -u          | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
#     target=$(
#       (echo "$tags"; echo "$branches") |
#         fzf-tmux --tac -- --ansi -d "\t" -n 2) || return
#     git checkout $(echo "$target" | awk '{print $2}')
#   fi
# }

## fzf checkout a git commit
# function gcoc() {
#   local commits commit
#   commits=$(git log --pretty=oneline --abbrev-commit --reverse) &&
#     commit=$(echo "$commits" | fzf --tac +s +m -e) &&
#     git checkout $(echo "$commit" | sed "s/ .*//")
# }

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

## tmux-cssh with auto-scaling IP detection
# tmux-asg () {
#   tmux-cssh $(asg ip $1)
# }

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