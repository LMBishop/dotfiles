# Source environment
source $HOME/.config/zsh/environment.zsh

# Source configurations
typeset -ga sources
sources+="$ZSH_CONFIG/plugins.zsh"
sources+="$ZSH_CONFIG/environment.zsh"
sources+="$ZSH_CONFIG/prompt.zsh"
sources+="$ZSH_CONFIG/aliases.zsh"
sources+="$ZSH_CONFIG/keybinds.zsh"
sources+="$ZSH_CONFIG/directories.zsh"

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

foreach file (`echo $sources`)
    if [[ -a $file ]]; then
        source $file
    fi
end

# ===============================
for file in $ZSH_CONFIG/other/*; do
    source "$file"
done

