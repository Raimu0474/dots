### zplug
export ZPLUG_HOME="$VENDOR_HOME/.zplug"

if [ ! -e "$ZPLUG_HOME/init.zsh" ]; then
  echo '=============================='
  echo 'zplug not exists...'
  echo 'downloading zplug'
  git clone https://github.com/zplug/zplug $ZPLUG_HOME
  echo 'complete!!!'
  echo '=============================='
fi
source "$ZPLUG_HOME/init.zsh"

zplug 'zsh-users/zsh-completions'
zplug 'zsh-users/zaw'
zplug 'zsh-users/zsh-syntax-highlighting', defer:2
zplug check || zplug install

### cdr の設定 (zplug load 前に書かないと zaw-cdr がスキップされる)
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook is-at-least
if is-at-least 4.3.10; then
  add-zsh-hook chpwd chpwd_recent_dirs
  zstyle ':chpwd:*' recent-dirs-max 5000
  zstyle ':chpwd:*' recent-dirs-default yes
fi

zplug load
