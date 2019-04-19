

###########
### env ###
###########
PROJECT_ENV="$HOME/dots/projects"

################
#### install ###
################


##############
### anyenv ###
##############
ANYENV_PATH="$HOME/dots/vendor/.anyenv"
if [ ! -e $ANYENV_PATH ];then
  git clone https://github.com/anyenv/anyenv $ANYENV_PATH
fi

export ANYENV_DEFINITION_ROOT="$ANYENV_PATH/anyenv-install"

export PATH="$ANYENV_PATH/bin:$PATH"

# if [ ! -e $ANYENV_PATH/anyenv_install ];then
#   anyenv install --init
# fi

if [ ! -e $HOME/.anyenv/envs/rbenv ];then
  anyenv install rbenv
fi

if [ ! -e $HOME/.anyenv/envs/pyenv ];then
  anyenv install pyenv
fi
eval "$(anyenv init -)"

#############
### zplug ###
#############

ZPLUG_HOME="$HOME/dots/vendor/.zplug"
if [ ! -e $ZPLUG_HOME ]; then
  git clone https://github.com/zplug/zplug $ZPLUG_HOME
fi
source "$ZPLUG_HOME/init.zsh"

zplug 'zsh-users/zsh-completions'
zplug 'zsh-users/zaw'
zplug 'zsh-users/zsh-syntax-highlighting', defer:2
zplug check || zplug install

#################################################################
### cdr の設定 (zplug load 前に書かないと zaw-cdr がスキップされる) ###
#################################################################
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook is-at-least
if is-at-least 4.3.10; then
  add-zsh-hook chpwd chpwd_recent_dirs
  zstyle ':chpwd:*' recent-dirs-max 5000
  zstyle ':chpwd:*' recent-dirs-default yes
fi

zplug load


#################
### functions ###
#################
function precmd () {
  psvar=()
  LANG=en_US.UTF-8 vcs_info
  [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"

  [[ -t 1 ]] || return
	[ $EMACS ] && return
    case $TERM in
      *xterm*|rxvt|(dt|k|E)term)
      print -Pn "\e]2;localhost\a"
      ;;
    esac
}

function toon {
  echo -n ""
}

function _update_vcs_info_msg() {
  psvar=()
  LANG=en_US.UTF-8 vcs_info
  [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}

function zaw-src-gitdir () {
	_dir=$(git rev-parse --show-cdup 2>/dev/null)
	if [ $? -eq 0 ]
	then
		candidates=( $(git ls-files ${_dir} | perl -MFile::Basename -nle \
												   '$a{dirname $_}++; END{delete $a{"."}; print for sort keys %a}') )
	fi

	actions=("zaw-src-gitdir-cd")
	act_descriptions=("change directory in git repos")
}

function zaw-src-gitdir-cd () {
	BUFFER="cd $1"
	zle accept-line
}


function peco-history-selection() {
  BUFFER=`history -n 1 | tail -r  | awk '!a[$0]++' | peco`
  CURSOR=$#BUFFER
  zle reset-prompt
}

function ruby-trunk-build() {
  BEFORE_PATH=`pwd`
  cd $HOME/src/ruby
  git pull
  autoconf
  ./configure --prefix=$HOME/.anyenv/envs/rbenv/versions/`date "+%Y%m%d_%H%M%S"` --with-opt-dir=`brew --prefix openssl1`
  make -j4
  sudo make install
  cd $BEFORE_PATH
}

#############
### alias ###
#############
alias '..'='cd ..'
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'

alias -g G='| grep'
alias -g L='| less'
alias -g H='| head'
alias -g T='| tail'
alias -g S='| sed'
alias -g C='| cat'
alias -g P='| peco'

alias 'be'='bundle exec'
alias g='git'

alias docom='docker-compose'
alias dcrun='docom run --rm'

alias vi='nvim'
alias vim='nvim'
alias vi_n='vi'
alias vim_n='vim'

alias ssh='~/dots/bin/ssh_change_iterm_profile.sh'

alias rip='kill -9'

##############
### prompt ###
##############

if [ $EMACS ]; then
	export TERM=xterm-256color
	PROMPT="%F{green}%~%f %{$fg[red]%}>%{$reset_color%} "
else
	PROMPT="%F{green}%~%f %{$fg[white]%}$(toon)%{$reset_color%} "
fi
PROMPT2="%_%% "
SPROMPT="%r is correct? [n,y,a,e]: "
RPROMPT="%1(v|%F{yellow}%1v%f|)%F{red}%T%f"

################
### settings ###
################

### emacs 風キーバインド
bindkey -e

### 色付けで色の名前が使えたりとか
autoload -Uz add-zsh-hook
autoload -U colors && colors

### vsc_info の設定
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn hg
zstyle ':vcs_info:*' formats '(%s)[%b] '
zstyle ':vcs_info:*' actionformats '(%s)[%b|%a] '
zstyle ':vcs_info:svn:*' branchformat '%b:r%r'


if is-at-least 4.3.10; then
  zstyle ':vcs_info:git:*' check-for-changes true
  zstyle ':vcs_info:git:*' stagedstr "+"
  zstyle ':vcs_info:git:*' unstagedstr "-"
  zstyle ':vcs_info:git:*' formats '(%s)[%b]%c%u'
  zstyle ':vcs_info:git:*' actionformats '(%s)[%b|%a]%c%u'
fi


add-zsh-hook precmd _update_vcs_info_msg
zstyle ':vcs_info:bzr:*' use-simple true

### history 設定
HISTFILE=~/.zsh_historyx
HISTSIZE=10000
SAVEHIST=10000

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

###########
### 補完 ###
###########
autoload -U compinit; compinit -C

### 補完方法毎にグループ化する。
zstyle ':completion:*' format '%B%F{blue}%d%f%b'
zstyle ':completion:*' group-name ''
### 補完侯補をメニューから選択する。
### select=2: 補完候補を一覧から選択する。補完候補が2つ以上なければすぐに補完する。
zstyle ':completion:*:default' menu select=2
### 補完候補に色を付ける。
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
### 補完候補がなければより曖昧に候補を探す。
### m:{a-z}={A-Z}: 小文字を大文字に変えたものでも補完する。
### r:|[._-]=*: 「.」「_」「-」の前にワイルドカード「*」があるものとして補完する。
#zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z} r:|[._-]=*'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

zstyle ':completion:*' keep-prefix
zstyle ':completion:*' recent-dirs-insert both
zstyle ':completion:*' completer _complete _ignored

## 補完候補をキャッシュする。
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path ~/.zsh/cache
## 詳細な情報を使わない
zstyle ':completion:*' verbose no

## sudo の時にコマンドを探すパス
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin

setopt no_beep  # 補完候補がないときなどにビープ音を鳴らさない。
setopt no_nomatch # git show HEAD^とかrake foo[bar]とか使いたい
setopt prompt_subst  # PROMPT内で変数展開・コマンド置換・算術演算を実行
setopt transient_rprompt  # コマンド実行後は右プロンプトを消す
setopt hist_ignore_dups   # 直前と同じコマンドラインはヒストリに追加しない
setopt hist_ignore_all_dups  # 重複したヒストリは追加しない
setopt hist_reduce_blanks
setopt hist_no_store
setopt hist_verify
setopt share_history  # シェルのプロセスごとに履歴を共有
setopt extended_history  # 履歴ファイルに時刻を記録
#setopt hist_expand  # 補完時にヒストリを自動的に展開する。
setopt append_history  # 複数の zsh を同時に使う時など history ファイルに上書きせず追加
setopt auto_cd  # ディレクトリ名だけで移動
setopt auto_pushd  # cd したら pushd
setopt auto_list  # 補完候補が複数ある時に、一覧表示
setopt auto_menu  # 補完候補が複数あるときに自動的に一覧表示する
#setopt auto_param_slash
setopt list_packed
setopt list_types
setopt no_flow_control
setopt print_eight_bit
setopt pushd_ignore_dups
setopt rec_exact
setopt autoremoveslash
unsetopt list_beep
setopt complete_in_word  # カーソル位置で補完する。
setopt glob
setopt glob_complete  # globを展開しないで候補の一覧から補完する。
setopt extended_glob  # 拡張globを有効にする。
setopt mark_dirs   # globでパスを生成したときに、パスがディレクトリだったら最後に「/」をつける。
setopt numeric_glob_sort  # 辞書順ではなく数字順に並べる。
setopt magic_equal_subst  # コマンドライン引数の --prefix=/usr とか=以降でも補完
setopt always_last_prompt  # 無駄なスクロールを避ける

## 実行したプロセスの消費時間が3秒以上かかったら
## 自動的に消費時間の統計情報を表示する。
REPORTTIME=3

### zaw
bindkey '^[d' zaw-cdr
bindkey '^[g' zaw-git-branches
bindkey '^[@' zaw-gitdir


zle -N peco-history-selection
bindkey '^R' peco-history-selection

zaw-register-src -n gitdir zaw-src-gitdir

########################################
### プロジェクト固有の設定があれば読み込み ###
########################################
for dir in $(find $PROJECT_ENV -type d -mindepth 1);do
  for file in $(find $dir -type f -mindepth 1);do
    source $file
  done 
done

export RUBOCOP_OPTS='-D -E -S'
# export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)

# rbenv用のパスを設定
eval "$(rbenv init -)"

export PATH="$HOME/.cargo/bin:$PATH"