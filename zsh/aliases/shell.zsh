alias c="clear"
alias v="nvim"

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en1 || ipconfig getifaddr en0"

# tmux
alias tml="tmux list-sessions"
alias tma="tmux -2 attach -t $1"
alias tmk="tmux kill-session -t $1"

# eza

alias ls="eza --icons=auto --hyperlink --group-directories-first"
alias la="eza --icons=auto --hyperlink --group-directories-first -la"
