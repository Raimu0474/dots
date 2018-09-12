## alias

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

for dir in $(find $PROJECT_ENV -mindepth 1 -type d);do
  for file in $(find $dir -mindepth 1 -type f);do
    source $file
  done 
done

alias docom='docker-compose'
alias dcrun='docom run --rm'

alias vi='nvim'
alias vim='nvim'
alias vi_n='vi'
alias vim_n='vim'
