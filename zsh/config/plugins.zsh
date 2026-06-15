os="$(uname -s)"

if [ "$os" = "Darwin" ]; then
  echo "todo"
elif [ "$os" = "Linux" ]; then
  if [ -f /etc/os-release ] && grep -qi '^ID=arch' /etc/os-release; then
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
  fi
fi


