fpath=(~/etc/zsh/completion $fpath)
autoload -U compinit && compinit
# zmodload -i zsh/complist

## case-insensitive completion
# zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

unsetopt menucomplete
setopt automenu

# match uppercase from lowercase, but not vice-versa
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache/$HOST

zstyle ':completion:*:hosts' hosts $hosts

## add simple colors to kill
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

## list of completers to use, approx is fuzzy matcher
# zstyle ':completion:*::::' completer _expand _complete _ignored _approximate
zstyle ':completion:*::::' completer _complete _approximate

## highlight current match from list
# zstyle ':completion:*' menu select=1 _complete _ignored _approximate

## insert all expansions for expand completer, this fixes emacs term bottom-line issue NOT
# zstyle ':completion:*:expand:*' tag-order all-expansions

## offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

zstyle ':completion:*' verbose yes # cmdline arg descriptions

## completion menu for file completion use ls colors
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"

# zstyle ':completion:*:ssh:*' tag-order users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
# zstyle ':completion:*:ssh:*' group-order hosts-domain hosts-host users hosts-ipaddr

## reload ssh completions when new hosts appear
## massive hack, copied from oh-my-zsh/lib/completion.zsh
# alias rh="source ~/etc/zsh/lib/completion.zsh"
# function rh {
#   # use /etc/hosts and known_hosts for hostname completion
#   [ -r /etc/ssh/ssh_known_hosts ] && _global_ssh_hosts=(${${${${(f)"$(</etc/ssh/ssh_known_hosts)"}:#[\|]*}%%\ *}%%,*}) || _global_ssh_hosts=()
#   [ -r ~/.ssh/known_hosts ] && _ssh_hosts=(${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[\|]*}%%\ *}%%,*}) || _ssh_hosts=()
#   [ -r ~/.ssh/config ] && _ssh_config=($(cat ~/.ssh/config | sed -ne 's/Host[=\t ]//p')) || _ssh_config=()
#   [ -r /etc/hosts ] && : ${(A)_etc_hosts:=${(s: :)${(ps:\t:)${${(f)~~"$(</etc/hosts)"}%%\#*}##[:blank:]#[^[:blank:]]#}}} || _etc_hosts=()
#   hosts=(
#     "$_ssh_config[@]"
#     "$_global_ssh_hosts[@]"
#     "$_ssh_hosts[@]"
#     "$_etc_hosts[@]"
#     "$HOST"
#     localhost
#   )
#   zstyle ':completion:*:hosts' hosts $hosts
# }

# ## run it every 5 min
# periodic () { rh }
# PERIOD=300

# ## quick hack for now, later fix the oh-my-zsh knife plugin for knife-solo
# compdef _hosts knife
# #compdef _hosts fleetctl