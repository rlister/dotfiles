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

## completion
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
  precmd () { vcs_info }        # update vcs before every prompt
  PROMPT=$'%F{blue}%T %F{cyan}%m:%2~ %F{green}%L:${AWS_VAULT:+$AWS_VAULT}:${vcs_info_msg_0_}%f%(!.#.$) '
fi

## extra setup for vterm
if [ "$INSIDE_EMACS" == "vterm" ]; then
  vterm_printf() { printf "\e]%s\e\\" "$1" }

  ## magic at end of prompt for vterm to use in vterm-previous-prompt
  vterm_prompt_end() { vterm_printf "51;A$(whoami)@$(hostname):$(pwd)" }
  PROMPT=$PROMPT'%{$(vterm_prompt_end)%}'

  ## set terminal title for vterm-buffer-name-string to use
  autoload -U add-zsh-hook
  add-zsh-hook -Uz chpwd (){ print -Pn "\e]2;%~\a" }
  print -Pn "\e]2;%~\a"  # start shell with correct title
fi

eval `dircolors ~/.dir_colors`

alias av='aws-vault exec'
alias be='bundle exec'
alias bi='bundle install'
alias bu='bundle update'
alias ec='emacsclient -t'
alias gu='git pull --rebase --autostash' # see https://github.com/aanand/git-up
alias k='kubectl'
alias kx='kubectx'
alias ll='ls -l'
alias ls='ls --color=auto -hF'
alias w2='AWS_REGION=us-west-2'

## run stax from correct location
function s() {
  (
    cd $(git rev-parse --show-toplevel)/ops;
    bundle exec stax "$@"
  )
}

function pget() {
  aws ssm get-parameter --name "$1" | jq -r '.Parameter | .Name + " " + .Value'
}

function ppath() {
  aws ssm get-parameters-by-path --path $1 | jq -r '.Parameters| .[] | .Name + " " + .Value'
}

function pput() {
  aws ssm put-parameter --name "$1" --value "$2" --type String --overwrite
}

## https://asdf-vm.com/#/core-manage-asdf-vm?id=add-to-your-shell
. /opt/asdf-vm/asdf.sh
