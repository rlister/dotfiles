## install:
## cd ~/src
## git clone https://github.com/pyenv/pyenv.git

## pyenv install location
export PYENV_ROOT="${HOME}/src/pyenv"
export PATH="${PYENV_ROOT}/bin:${PATH}"

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi