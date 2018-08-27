### prompt
if [ $EMACS ]; then
	export TERM=xterm-256color
	PROMPT="%F{green}%~%f %{$fg[red]%}>%{$reset_color%} "
else
	PROMPT="%F{green}%~%f %{$fg[white]%}$(toon)%{$reset_color%} "
fi
PROMPT2="%_%% "
SPROMPT="%r is correct? [n,y,a,e]: "
RPROMPT="%1(v|%F{yellow}%1v%f|)%F{red}%T%f"