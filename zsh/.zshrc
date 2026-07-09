# Source environment
source $HOME/.config/zsh/environment.zsh

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
 
# Source configurations
typeset -ga sources
sources+="$ZSH_CONFIG/plugins.zsh"
sources+="$ZSH_CONFIG/environment.zsh"
sources+="$ZSH_CONFIG/prompt.zsh"
sources+="$ZSH_CONFIG/aliases.zsh"

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
 
foreach file (`echo $sources`)
    if [[ -a $file ]]; then
        source $file
    fi
end

# ===============================
for file in $ZSH_CONFIG/other/*; do
    source "$file"
done

