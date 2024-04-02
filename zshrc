# -*- mode: shell-script; -*-

HISTFILE=~/.zsh_history
SAVEHIST=10000                  # num lines to keep in histfile
HISTSIZE=1024                   # num lines to keep in session
WORDCHARS=''                    # meta-move on all non-word chars

setopt no_beep                  # if you beep I will be forced to kill you
setopt interactive_comments     # allow comments in interactive shells
setopt autopushd                # implict pusgd on every dir change
setopt pushd_ignore_dups        # but only one copy of ech dir
setopt hist_ignore_dups         # unique history entries
setopt hist_expire_dups_first   # when trimming history, lose oldest duplicates first
setopt hist_reduce_blanks       # trim blanks
setopt hist_verify              # show before executing history commands
setopt append_history           # append history list to the history file
setopt inc_append_history       # add commands as they are typed, don't wait until shell exit
unsetopt share_history          # share hist between sessions
setopt extended_history         # save timestamp of command and duration
setopt bang_hist                # !keyword
setopt auto_remove_slash        # space after completed dir removes slash
setopt print_exit_value         # print return value if non-zero
unsetopt hup                    # no hup signal at shell exit
unsetopt ignore_eof             # do not exit on end-of-file
unsetopt nomatch                # makes zsh play nice with square brackets
unsetopt menu_complete          # do not autoselect the first completion entry
unsetopt SHINSTDIN
setopt prompt_subst             # do parameter expansion in prompt string

eval `dircolors ~/.dir_colors`

fpath=($fpath ~/.zsh/completion)

autoload -U compinit && compinit
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}" # file completion colors
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'      # match uppercase from lower

## bash completion compatibility
autoload bashcompinit && bashcompinit
complete -C aws_completer aws

## builtin git support for prompt
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr     '%F{yellow}+'
zstyle ':vcs_info:*' unstagedstr   '%F{red}-'
zstyle ':vcs_info:*' formats       ' %c%u%F{green}%b%f'
zstyle ':vcs_info:*' actionformats ' %c%u%F{green}%b|%F{red}%a%f '

## prompt string
if [ "$TERM" == "dumb" ]; then
  unsetopt zle
  PS1='%2~%(!.#.$) '
else
  precmd () {
    vcs_info
    KCTX=$(kubie info ctx 2> /dev/null)
  }

  PROMPT=$'${SSH_TTY+%m }%F{cyan}%2~%F{green}${AWS_PROFILE:+ ${AWS_PROFILE//-arcadia-admin/}}${AWS_REGION:+:${AWS_REGION//??-/}}${KCTX:+:${KCTX}}${vcs_info_msg_0_}%f%(!.#.$) '
fi

## extra setup for vterm
if [ "$INSIDE_EMACS" == "vterm" ]; then
  ## how to send data to vterm in screen and xterm
  vterm_printf() {
    if [ -n "$STY" ]; then
      printf "\eP\e]%s\007\e\\" "$1"
    else
      printf "\e]%s\e\\" "$1"
    fi
  }

  ## magic at end of prompt for vterm to use in vterm-previous-prompt
  vterm_prompt_end() { vterm_printf "51;A$(whoami)@$(hostname):$(pwd)" }
  PROMPT=$PROMPT'%{$(vterm_prompt_end)%}'

  ## set terminal title for vterm-buffer-name-string to use
  autoload -U add-zsh-hook
  add-zsh-hook -Uz chpwd (){ print -Pn "\e]2;%~\a" }
  print -Pn "\e]2;%~\a"  # start shell with correct title
fi

## emacs-vterm and xterm
bindkey ';5C' forward-word
bindkey ';5D' backward-word
bindkey ';5~' kill-word

## xterm
bindkey '^H' backward-kill-word

alias av='aws-vault exec'
alias be='bundle exec'
alias bi='bundle install'
alias bu='bundle update'
alias ec='emacsclient -t'
alias flush='ssh pi pihole restartdns'
alias gd='rclone mount gd: ~/gd'
alias gu='git pull --rebase --autostash' # see https://github.com/aanand/git-up
alias ll='ls -l'
alias ls='ls --color=auto -hF'

alias k='kubectl'
# alias kn='kubens'
alias kn='kubie ns'
# alias kx='kubectx'
alias kx='kubie ctx'
alias tf='terraform'

# alias e1='export AWS_REGION=us-east-1 AWS_DEFAULT_REGION=us-east-1'
# alias w1='export AWS_REGION=us-west-1 AWS_DEFAULT_REGION=us-west-1'
# alias w2='export AWS_REGION=us-west-2 AWS_DEFAULT_REGION=us-west-2'
alias e1='export AWS_REGION=us-east-1'
alias w1='export AWS_REGION=us-west-1'
alias w2='export AWS_REGION=us-west-2'

alias gac='OKTA_PASSWORD=$(pass show arcadia.okta.com|head -1) gimme-aws-creds -m'
alias dev='export AWS_PROFILE=dev AWS_REGION=us-east-1'
alias prod='export AWS_PROFILE=prod AWS_REGION=us-east-1'
alias data='export AWS_PROFILE=data AWS_REGION=us-east-1'
alias root='export AWS_PROFILE=root AWS_REGION=us-east-1'

alias dev1='AWS_PROFILE=dev AWS_REGION=us-east-1 kubie ctx dev1'
alias dev3='AWS_PROFILE=dev AWS_REGION=us-west-1 kubie ctx dev3'
alias ai1='AWS_PROFILE=dev AWS_REGION=us-east-1 kubie ctx ai1'
alias int1='AWS_PROFILE=prod AWS_REGION=us-east-1 kubie ctx int1'
alias uat1='AWS_PROFILE=prod AWS_REGION=us-east-1 kubie ctx uat1'
alias prod1='AWS_PROFILE=prod AWS_REGION=us-east-1 kubie ctx prod1'
alias prod3='AWS_PROFILE=prod AWS_REGION=us-west-1 kubie ctx prod3'
alias data1='AWS_PROFILE=data AWS_REGION=us-east-1 kubie ctx data1'

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
