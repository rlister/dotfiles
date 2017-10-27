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

## simple completion of an array
compctl -k '(spree-admin spree-dev nimbus-admin nimbus-dev admin dev ric)' av aws-vault