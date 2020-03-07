## aws-cli cmdline completion
## aws-cli v1:
#source /usr/bin/aws_zsh_completer.sh
## aws-cli v2:
complete -C aws_completer aws

## assuming roles with https://github.com/coinbase/assume-role
source /usr/local/bin/assume-role
alias ar='assume-role'
alias arr='assume-role ${AWS_ACCOUNT_NAME} ${AWS_ACCOUNT_ROLE}' #  refresh token

## switching creds with https://github.com/99designs/aws-vault
alias ce='aws-vault exec'
function av() {aws-vault exec $*}

## make it easier to tag docker images
function acr () {
  echo -n "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"
}

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

## run stax from correct location
function s() {
  (
    cd $(git rev-parse --show-toplevel)/ops;
    bundle exec stax $*
  )
}

alias lmi=let-me-in

## aws regions
alias e1='AWS_REGION=us-east-1'
alias w1='AWS_REGION=us-west-1'
alias w2='AWS_REGION=us-west-2'
alias s1='AWS_REGION=sa-east-1'
