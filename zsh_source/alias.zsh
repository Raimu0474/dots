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

for dir in $(find $PROJECT_ENV -type d -mindepth 1);do
  for file in $(find $dir -type f -mindepth 1);do
    source $file
  done 
done

alias docom='docker-compose'
alias dcrun='docom run --rm'