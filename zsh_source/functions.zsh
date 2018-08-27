### functions

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

# markdownをw3mで見る
function ress() {
    FILENAME=$1
    if [ $# -lt 1 ]; then
        echo "Usage: $0 FILENAME"
    else
        github-markup $FILENAME | w3m -T text/html
    fi
}
