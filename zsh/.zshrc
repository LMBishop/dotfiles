export ZSH="/Users/leonardo/.oh-my-zsh"

DEFAULT_USER="leonardo"

autoload -Uz vcs_info

directory() {
   echo "%{$fg_bold[magenta]%}%~%{$reset_color%}"
}

current_time() {
   echo "%{$fg[white]%}[%*]"
}

return_status() {
  local LAST_EXIT_CODE=$?
  if [[ $LAST_EXIT_CODE -ne 0 ]]; then
    local EXIT_CODE_PROMPT=' '
    EXIT_CODE_PROMPT+="%{$fg_bold[red]%}$LAST_EXIT_CODE%{$reset_color%}"
    echo "$EXIT_CODE_PROMPT "
  fi
}

precmd() {
    vcs_info
    VCS_STATUS=""
    if [[ -n ${vcs_info_msg_0_} ]]; then
        STATUS=$(command git status --porcelain 2> /dev/null | tail -n1)
        if [[ -n $STATUS ]]; then
	    VCS_STATUS="(%F{yellow}${vcs_info_msg_0_}%f) "
        else
	    VCS_STATUS="(%F{green}${vcs_info_msg_0_}%f) "
        fi
    fi
    PROMPT='%B$(directory)%b %# '
    RPROMPT='$(return_status)${VCS_STATUS}$(current_time)'
}

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git*' formats "%b%u%c"
zstyle ':vcs_info:git*' actionformats "%b|%a%u%c"
zstyle ':vcs_info:*' unstagedstr ' *'
zstyle ':vcs_info:*' stagedstr ' +'

setopt prompt_subst

plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

export PATH="/opt/homebrew/opt/python@3.10/bin:$PATH"
alias vim="nvim"
alias vi="nvim"
alias vimdiff="nvim -d"
