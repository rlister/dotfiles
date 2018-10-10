## aws-cli cmdline completion
source /usr/local/bin/aws_zsh_completer.sh

## assuming roles with https://github.com/coinbase/assume-role
source /usr/local/bin/assume-role
alias ar='assume-role'

## switching creds with https://github.com/99designs/aws-vault
alias ce='aws-vault exec'
function av() {aws-vault exec $*}