for xxenv in `read_each_config "$ZSH_HOME/anyenv/anyenv_envs"`; do
  if ! type $xxenv >/dev/null 2>&1; then
    echo "=============================="
    echo "$xxenv not exists"
    echo "install $xxenv..."
    anyenv install $xxenv
    echo "complete!!!"
    echo "=============================="
  fi
done