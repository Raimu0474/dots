for shell in `ls "$DOTS_HOME/zsh_source/bin"`; do
  perm=`ls -l "$DOTS_HOME/zsh_source/bin/$shell"`
  if [ ${perm:0:11} != "-rwxr-xr-x" ]; then
    chmod 755 "$DOTS_HOME/zsh_source/bin/$shell"
  fi
done
export PATH="$DOTS_HOME/zsh_source/bin:$PATH"
export PATH="$HOME/zsh_source/bin:$PATH"