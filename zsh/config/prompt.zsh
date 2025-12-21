autoload -Uz vcs_info

directory() {
   echo "%{$fg_bold[magenta]%}%~%{$reset_color%}"
}

current_time() {
   echo "%{$fg[white]%}[%*]"
}

container_l() {
  if [[ -n "${CONTAINER_ID:-}" ]]; then
    echo "%{$fg[cyan]%}*%{$reset_color%} "
  fi
}

container_r() {
  if [[ -n "${CONTAINER_ID:-}" ]]; then
    echo "(%{$fg[cyan]%}$CONTAINER_ID%{$reset_color%}) "
  fi
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
    PROMPT='$(container_l)%B$(directory)%b %# %f'
    RPROMPT='$(return_status)${VCS_STATUS}$(container_r)$(current_time)%f'
}

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git*' formats "%b%u%c"
zstyle ':vcs_info:git*' actionformats "%b|%a%u%c"
zstyle ':vcs_info:*' unstagedstr ' *'
zstyle ':vcs_info:*' stagedstr ' +'

setopt prompt_subst

