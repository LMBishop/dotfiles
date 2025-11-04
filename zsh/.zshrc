# Source environment
source $HOME/.config/zsh/environment.zsh

# Load plugins
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# Source configurations
typeset -ga sources
sources+="$ZSH_CONFIG/environment.zsh"
sources+="$ZSH_CONFIG/prompt.zsh"
sources+="$ZSH_CONFIG/aliases.zsh"
 
foreach file (`echo $sources`)
    if [[ -a $file ]]; then
        source $file
    fi
end

# ===============================
for file in $ZSH_CONFIG/other/*; do
    source "$file"
done

