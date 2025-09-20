# -*- mode: shell-script; -*-

HISTFILE=~/.zsh_history
SAVEHIST=10000                  # num lines to keep in histfile
HISTSIZE=1024                   # num lines to keep in session
WORDCHARS=''                    # meta-move on all non-word chars
PROMPT_EOL_MARK=''              # hide % on partial newlines

setopt append_history           # append history list to the history file
setopt auto_remove_slash        # space after completed dir removes slash
setopt autopushd                # implict pushd on every dir change
setopt bang_hist                # !keyword
setopt extended_history         # save timestamp of command and duration
setopt hist_expire_dups_first   # when trimming history, lose oldest duplicates first
setopt hist_ignore_dups         # unique history entries
setopt hist_reduce_blanks       # trim blanks
# unsetopt hist_verify              # show before executing history commands
setopt inc_append_history       # add commands as they are typed, don't wait until shell exit
setopt interactive_comments     # allow comments in interactive shells
setopt no_beep                  # if you beep I will be forced to kill you
setopt print_exit_value         # print return value if non-zero
setopt prompt_subst             # do parameter expansion in prompt string
setopt pushd_ignore_dups        # but only one copy of ech dir
unsetopt SHINSTDIN
unsetopt hup                    # no hup signal at shell exit
unsetopt ignore_eof             # do not exit on end-of-file
unsetopt menu_complete          # do not autoselect the first completion entry
unsetopt nomatch                # makes zsh play nice with square brackets
unsetopt share_history          # share hist between sessions

eval `dircolors ~/.dir_colors`

fpath=($fpath ~/.zsh/completion)

autoload -U compinit && compinit
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}" # file completion colors
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'      # match uppercase from lower

autoload bashcompinit && bashcompinit # for aws-cli
complete -C aws_completer aws

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr     '%F{yellow}+'
zstyle ':vcs_info:*' unstagedstr   '%F{red}-'
zstyle ':vcs_info:*' formats       ' %c%u%F{green}%b%f'
zstyle ':vcs_info:*' actionformats ' %c%u%F{green}%b|%F{red}%a%f '

# if [ "$TERM" == "dumb" ]; then
#   unsetopt zle
#   PS1='%2~%(!.#.$) ' # for eshell?
# else

precmd () {
  vcs_info
  prof=${AWS_PROFILE:+ ${AWS_PROFILE}:${AWS_REGION//??-/}:${KX}}
}

PS1=$'${SSH_TTY+%m }%F{cyan}%2~%F{green}${prof}${vcs_info_msg_0_}%f%(!.#.$) '

if [ "$INSIDE_EMACS" == "vterm" ]; then
  # vterm_printf() { printf "\e]%s\e\\" "$1" } #screen
  # vterm_printf() { printf "\eP\e]%s\007\e\\" "$1" } #xterm

  if [ "${TERM%%-*}" = "screen" ]; then
    vterm_printf() { printf "\eP\e]%s\007\e\\" "$1" }
  else
    vterm_printf() { printf "\e]%s\e\\" "$1" }
  fi

  # alias clear='vterm_printf "51;Evterm-clear-scrollback";tput clear'

  vterm_prompt_end() { vterm_printf "51;A$(whoami)@$(hostname):$(pwd)" } #vterm-previous-prompt
  PS1=$PS1'%{$(vterm_prompt_end)%}'

  autoload -U add-zsh-hook
  add-zsh-hook -Uz chpwd() { print -Pn "\e]2;%~\a" }  #term title for vterm-buffer-name-string
  # chpwd "." #start with correct title
  print -Pn "\e]2;%~\a"  # start shell with correct title
fi

bindkey ';5C' forward-word      # C-right
bindkey ';5D' backward-word     # C-left
bindkey ';5~' kill-word         # C-backspace
bindkey '^H' backward-kill-word # xterm

alias be='bundle exec'
alias bi='bundle install'
alias btc=bluetoothctl
alias bu='bundle update'
alias cr='. /usr/share/chruby/chruby.sh; chruby 3'
alias ec='emacsclient -t'
alias flush='ssh pi@192.168.1.2 pihole restartdns'
alias gd='rclone mount gd: ~/mnt'
alias gu='git pull --rebase --autostash' # see https://github.com/aanand/git-up
alias h=history
alias ll='ls -l'
alias ls='ls --color=auto -hF'
alias m=less

alias k=kubectl
alias kai=kubectl-ai
alias kar=kubectl-argo-rollouts
alias tf=terraform

alias dev='export AWS_PROFILE=dev-admin AWS_REGION=us-east-1'
alias devdev='export AWS_PROFILE=dev-developer AWS_REGION=us-east-1'
alias devread='export AWS_PROFILE=dev-read AWS_REGION=us-east-1'
alias prod='export AWS_PROFILE=prod-admin AWS_REGION=us-east-1'
alias data='export AWS_PROFILE=data-admin AWS_REGION=us-east-1'
alias ops='export AWS_PROFILE=ops-admin AWS_REGION=us-east-1'
alias root='export AWS_PROFILE=root-admin AWS_REGION=us-east-1'
alias ext='export AWS_PROFILE=ext-admin AWS_REGION=us-east-1'
alias gen='export AWS_PROFILE=gen-admin AWS_REGION=us-west-1'

alias e1='export AWS_REGION=us-east-1'
alias w1='export AWS_REGION=us-west-1'
alias w2='export AWS_REGION=us-west-2'

# alias dev1='export AWS_PROFILE=dev AWS_REGION=us-east-1 KUBECONFIG=~/.kube/dev1.yaml'
alias dev1='dev; e1; kx dev1'
alias dev3='dev; w1; kx dev3'
alias prod1='prod; e1; kx prod1'
alias prod3='prod; w1; kx prod3'
alias int1='prod; e1; kx int1'
alias uat1='prod; e1; kx uat1'
alias ai1='dev; e1; kx ai1'
alias aidev1='dev; e1; kx aidev1'
alias data1='data; e1; kx data1'

alias devp='export AWS_PROFILE=devp-admin AWS_REGION=us-east-1; kx dev'
alias prodp='export AWS_PROFILE=prodp-admin AWS_REGION=us-east-1; kx prod'
alias rootp='export AWS_PROFILE=rootp-admin AWS_REGION=us-east-1'
alias perchprod='export AWS_PROFILE=perch-prod-admin AWS_REGION=us-east-1'

function ku() {
  aws eks update-kubeconfig --kubeconfig ~/.kube/$1.yaml --name $1 --alias $1
}

function kx() {
  export KUBECONFIG=~/.kube/$1.yaml KX=$1
}

function kiali() {
  kubectl -n istio-system port-forward services/kiali 20001 &
  sleep 1
  xdg-open http://localhost:20001
  fg
}

function kubeflow() {
  kubectl port-forward svc/istio-ingressgateway --address 127.0.0.1 -n istio-system 8080:80 &
  sleep 1
  xdg-open http://localhost:8080
}

function prom() {
  kubectl -n prometheus port-forward deploy/prometheus-server 9090 &
  sleep 1
  xdg-open http://localhost:9090
  fg
}

## run stax from correct location
function s() {
  (
    cd -q $(git rev-parse --show-toplevel)/ops;
    bundle exec stax "$@"
  )
}

function logtail {
  account=$(aws sts get-caller-identity --query Account --output text)
  aws logs start-live-tail --log-group-identifiers "arn:aws:logs:${AWS_REGION}:${account}:log-group:$1"
}

alias twfix='sudo /bin/sh -c "echo options single-request >> /etc/resolv.conf"'
alias brown='sox -q -c 2 -r 32000 -n -d -D synth 12:00:00 brownnoise vol 0.1 fade t 3'
alias kcurl='kubectl run -it --rm rictest --image curlimages/curl -l sidecar.istio.io/inject=true -- sh'

function hr() {
  app=$(basename $(git rev-parse --show-toplevel))
  ref=$(git symbolic-ref --short HEAD)
  prefix=$(printf "${app}-${ref}" | tr -c '[:alnum:]\n' '-')
  printf ${prefix:0:53} | tr '[:upper:]' '[:lower:]' | sed -e 's/-\+$//' | xsel -ib
}

function map() {
  cmd=$1; shift
  for x in $@; do echo apply $x; $cmd $x; done
}
