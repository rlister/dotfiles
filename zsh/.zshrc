# -*- mode: shell-script; -*-
source ~/.zsh/setopt.zsh
source ~/.zsh/prompt.zsh
source ~/.zsh/aliases.zsh
source ~/.zsh/completion.zsh
source ~/.zsh/ruby.zsh
source ~/.zsh/tmuxinator.zsh

## TODO this does not belong here
PATH="${HOME}/bin:${PATH}:/usr/local/sbin:/usr/local/bin:/opt/local/bin:${HOME}/local/node/bin:${HOME}/code/go/bin:/usr/local/opt/go/libexec/bin"
export PATH