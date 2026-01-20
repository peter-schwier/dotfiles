
printf '%s %s\n$-=%s\n$$=%s\n$0=%s\n%s\n%s\n\n' "$(date -Iseconds)" {{ . | quote }} "$-" "$$" "$0" "$(env)" "$(command -v shopt >/dev/null && shopt -p || echo '')" >> ~/.log
export ENV="$HOME/.shenv"
export BASH_ENV="$HOME/.bashenv"
