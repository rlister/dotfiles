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

## env file changer
# ce () {
#   if [[ ARGC -eq 1 ]] ; then
#     source ~/etc/env/$1 && export CE=$1
#   else
#     local -a envs
#     envs=("${(f)$(ls ~/etc/env/)}")
#     for x in $envs; do
#       if [[ "$x" == "$CE" ]]; then
#         echo "* $x"
#       else
#         echo "  $x"
#       fi
#     done
#   fi
# }

## really want this just for tmux
if [ "$TERM" != "dumb" ] ; then

  ## last part of dir in title/tmux
  precmd () {
    vcs_info
    # _ruby="$(chruby|grep '*'|sed -e 's/ \* ruby-//')"
    # print -Pn "\e]0;%~\a"
  }

  ## first part of job in title/tmux
  # preexec () {
  #   # arg=$1
  #   # print -Pn "\e]0;$arg[(w)1]\a"
  # }
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

## to do emacs-specific stuff ...
# if [[ -z "${INSIDE_EMACS}" ]]; then
#   source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# fi