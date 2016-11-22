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

PROMPT=$'%F{blue}%T %F{cyan}%4~ %F{green}%L:${AWS_VAULT:+$AWS_VAULT}${vcs_info_msg_0_}%f\n%(!.#.$) '

## right prompt if not emacs shell
# if [ "$TERM" != "dumb" ]; then
#   RPROMPT='%L:${AWS_VAULT:+$AWS_VAULT}${vcs_info_msg_0_}%f'
#   setopt transient_rprompt # only show on current line
# fi

## change emacs dir with shell dir; want this in multi-term but not emacs shell
if [ -n "$INSIDE_EMACS" ] && [ "$TERM" != "dumb" ]; then
  ## reset these at startup so we do not get tramp mangling local hostname
  print -P "\033AnSiTc %~"
  print -P "\033AnSiTu %n"

  ## run on every dir change; note that on mac %M sends foo.local, which
  ## ansi-term does not recognise as localhost, but hostname sends foo.home,
  ## which it does (and thus removes hostname from default-directory)
  chpwd () {
    print -P "\033AnSiTc %~"
    print -P "\033AnSiTu %n"
    print -P "\033AnSiTh $(hostname -f)"
  }
fi