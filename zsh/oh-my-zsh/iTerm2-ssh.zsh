function tabc() {
  NAME=$1; if [ -z "$NAME" ]; then NAME="Default"; fi 
  echo -e "\033]50;SetProfile=$NAME\a"
}

function tab-reset() {
    NAME="Default"
    echo -e "\033]50;SetProfile=$NAME\a"
}

function colorssh() {
    if [[ -n "$ITERM_SESSION_ID" ]]; then
        trap "tab-reset" INT EXIT
        if [[ "$*" =~ "ceres" ]]; then
            tabc "SSH - Ceres"
        elif [[ "$*" =~ "ug04" || "$*" =~ "tw" ]]; then
            tabc "SSH - SoCS"
        else
            tabc "SSH - Unknown"
        fi
#	tabc SSH
    fi
    ssh $*
}
compdef _ssh tabc=ssh

alias ssh="colorssh"

