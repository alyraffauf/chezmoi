status is-interactive; or return

if type -q eza
    alias eza 'eza --icons auto --git --group-directories-first --header'
    alias l 'eza -lah'
    alias la 'eza -a'
    alias ll 'eza -l'
    alias lla 'eza -la'
    alias ls eza
    alias lt 'eza --tree'
    alias tree 'eza --tree'
end

alias grep 'grep --color=auto'
