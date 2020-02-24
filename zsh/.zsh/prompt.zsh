# autoload -U colors && colors

## new builtin git support
## http://zsh.sourceforge.net/Doc/Release/User-Contributions.html#Version-Control-Information
autoload -Uz vcs_info

setopt prompt_subst
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr     '%F{yellow}+'
zstyle ':vcs_info:*' unstagedstr   '%F{red}-'
# zstyle ':vcs_info:*' formats       ' %c%u%F{green}%b%f' '%R' # R is expt for dotenv
zstyle ':vcs_info:*' formats       ' %c%u%F{green}%b%f'
zstyle ':vcs_info:*' actionformats ' %c%u%F{green}%b|%F{red}%a%f '

## update vcs on every prompt
if [ "$TERM" != "dumb" ] ; then
  precmd () {
    vcs_info
  }
fi

[[ $TERM == "dumb" ]] && unsetopt zle && PS1='$ '

## report assume-role settings in prompt
function aws_account {
  [ "$AWS_ACCOUNT_NAME" ] && [ "$AWS_ACCOUNT_ROLE" ] && echo "%F{blue}$AWS_ACCOUNT_NAME/$AWS_ACCOUNT_ROLE%f"
}

PROMPT=$'%F{blue}%T %F{cyan}%2~ %F{green}%L:${AWS_VAULT:+$AWS_VAULT}:$(aws_account)${vcs_info_msg_0_}%f%(!.#.$) '

if [ "$INSIDE_EMACS" == "vterm" ]; then
  chpwd() {
    print -Pn "\e]51;A%~/\e\\";
  }
fi
