## aws-cli cmdline completion
source /usr/local/bin/aws_zsh_completer.sh

## switching creds with https://github.com/99designs/aws-vault
alias ce='aws-vault exec'
function av() {aws-vault exec $*}