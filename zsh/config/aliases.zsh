# Neovim
alias vim="nvim"
alias vi="nvim"
alias vimdiff="nvim -d"

# Python version
alias python="python3"

# Ls to exa
alias ls="exa --icons"                                                         
alias ll="exa -lbhF --icons --git"                                             
alias llm="exa -lbhd --icons --git --sort=modified"                            
alias la="exa -lbahF --icons --git"                                           
alias lA="exa -lbhHigUmuSa --icons --time-style=long-iso --git --color-scale" 
alias lx="exa -lbhHigUmuSa@ --icons --time-style=long-iso --git --color-scale"
alias lS="exa -1"                                                             
alias lt="exa --tree --level=2"                                        

# iproute2 colours
alias ip="ip -c"

# ParUI
alias pi="parui -p=yay"

# Zsh
alias cathex="while read -r line; do echo -e $line; done"

# man
alias man='MANWIDTH=$((COLUMNS > 80 ? 80 : COLUMNS)) man'

