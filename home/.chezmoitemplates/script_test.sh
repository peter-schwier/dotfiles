
printf '%s %s $-=%s $$=%s $0=%s\n' "$(date -Iseconds)" {{ . | quote }} "$-" "$$" "$0" >> ~/.log
