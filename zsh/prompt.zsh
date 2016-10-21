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

if [ "$TERM" != "dumb" ] ; then
  precmd () {
    vcs_info
  }
fi

## put tmux window number into prompt
# tmux_window=$(tmux display-message -p '#I')
# PROMPT='%F{blue}%T %F{magenta}${_ruby}%F{blue}${AWS_VAULT:+ $AWS_VAULT} %L:%F{cyan}%~${vcs_info_msg_0_}%f%(!.#.$) '
PROMPT='%F{blue}%T${AWS_VAULT:+ $AWS_VAULT} %L:%F{cyan}%~${vcs_info_msg_0_}%f%(!.#.$) '

# setopt transient_rprompt #only show on current prompt
# RPROMPT="%T"

## change emacs dir with shell dir; want this in multi-term but not emacs shell
if [ -n "$INSIDE_EMACS" ] && [ "$TERM" != "dumb" ]; then
  ## reset these at startup so we do not get tramp mangling local hostname
  print -P "\033AnSiTc %~"
  print -P "\033AnSiTu %n"

  ## run on every dir change
  chpwd () {
    print -P "\033AnSiTc %~"
  }
fi