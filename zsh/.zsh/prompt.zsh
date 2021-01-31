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

## both dumb and smart prompts
if [ "$TERM" == "dumb" ]; then
  unsetopt zle
  PS1='%2~%(!.#.$) '
else
  ## update vcs before every prompt
  precmd () {
    vcs_info
  }

  ## report assume-role settings in prompt
  function aws_account {
    [ "$AWS_ACCOUNT_NAME" ] && [ "$AWS_ACCOUNT_ROLE" ] && echo "%F{blue}$AWS_ACCOUNT_NAME/$AWS_ACCOUNT_ROLE%f"
  }

  PROMPT=$'%F{blue}%T %F{cyan}%2~ %F{green}%L:${AWS_VAULT:+$AWS_VAULT}:$(aws_account)${vcs_info_msg_0_}%f%(!.#.$) '
fi

## emacs vterm hackage
if [ "$INSIDE_EMACS" == "vterm" ]; then
  ## used below
  vterm_printf() {
    printf "\e]%s\e\\" "$1"
  }

  ## allow vterm to clear scrollback with C-c C-l
  alias clear='vterm_printf "51;Evterm-clear-scrollback";tput clear'

  ## magic at end of prompt for vterm to use in vterm-previous-prompt
  vterm_prompt_end() {
    vterm_printf "51;A$(whoami)@$(hostname):$(pwd)";
  }

  setopt PROMPT_SUBST
  PROMPT=$PROMPT'%{$(vterm_prompt_end)%}'

  ## set terminal title for vterm-buffer-name-string to use
  autoload -U add-zsh-hook
  add-zsh-hook -Uz chpwd (){ print -Pn "\e]2;%~\a" }

  ## start shell with correct title
  print -Pn "\e]2;%~\a"
fi
