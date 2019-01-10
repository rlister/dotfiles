## aws-cli cmdline completion
source /usr/local/bin/aws_zsh_completer.sh

## assuming roles with https://github.com/coinbase/assume-role
source /usr/local/bin/assume-role
alias ar='assume-role'
alias arr='assume-role ${AWS_ACCOUNT_NAME} ${AWS_ACCOUNT_ROLE}' #  refresh token

## switching creds with https://github.com/99designs/aws-vault
alias ce='aws-vault exec'
function av() {aws-vault exec $*}

# ## install sam: pip3 install --user aws-sam-cli
# export PYTHON3_BASE=$(python3 -m site --user-base)
# alias sam=${PYTHON3_BASE}/bin/sam

function pls() {
  aws ssm describe-parameters | jq -r '.Parameters| .[] | .Name'
}

function pget() {
  aws ssm get-parameter --name "$1" | jq -r '.Parameter | .Name + " " + .Value'
}

function ppath() {
  aws ssm get-parameters-by-path --path $1 | jq -r '.Parameters| .[] | .Name + " " + .Value'
}

function pput() {
  aws ssm put-parameter --name "$1" --value "$2" --type String --overwrite
}