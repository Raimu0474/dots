export PATH="$VENDOR_HOME/.anyenv/bin:$PATH"
if type anyenv >/dev/null 2>&1; then
  echo '=============================='
  echo 'anyenv not exists'
  echo 'download and install anyenv...'
  git clone https://github.com/riywo/anyenv "$VENDOR_HOME/.anyenv"
  echo 'complete!!!'
  echo '=============================='
fi