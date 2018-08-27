export ANYENV_ROOT="$VENDOR_HOME/.anyenv"
export PATH="$ANYENV_ROOT/bin:$PATH"
# initialize anyenv
if ! type anyenv >/dev/null 2>&1; then
  echo '=============================='
  echo 'anyenv not exists'
  echo 'download and install anyenv...'
  git clone https://github.com/riywo/anyenv "$VENDOR_HOME/.anyenv"
  echo 'complete!!!'
  echo '=============================='
fi
eval "$(anyenv init -)"

source "$ZSH_HOME/anyenv/install_envs.zsh"
