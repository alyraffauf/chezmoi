status is-login; and begin

    # Login shell initialisation

end

status is-interactive; and begin

    # Abbreviations

    # Aliases
    alias eza 'eza --icons auto --git --group-directories-first --header'
    alias l 'eza -lah'
    alias la 'eza -a'
    alias ll 'eza -l'
    alias lla 'eza -la'
    alias ls eza
    alias lt 'eza --tree'
    alias tree 'eza --tree'

    # Interactive shell initialisation
    # Set up Homebrew environment if available
    if command -v brew > /dev/null
      eval (brew shellenv)
    end

    # Set TERM for Ghostty terminal
    if test "$TERM_PROGRAM" = ghostty
        set -gx TERM xterm-256color
    end

    zoxide init fish --cmd cd | source

    direnv hook fish | source
end
