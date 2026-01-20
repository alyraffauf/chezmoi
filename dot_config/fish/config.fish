status is-login; and begin

    # Login shell initialisation

end

status is-interactive; and begin

    # Abbreviations

    # Aliases
    alias docker 'podman'

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

    # Interactive shell initialisation

    # Set up nix
    if test -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish'
        source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish'
    end

    # Set up Homebrew environment if available
    set -l homebrew_prefix ""

    if test -x /home/linuxbrew/.linuxbrew/bin/brew
       set homebrew_prefix /home/linuxbrew/.linuxbrew
    else if test -x /opt/homebrew/bin/brew
       set homebrew_prefix /opt/homebrew
    end

    if test -n "$homebrew_prefix"
        eval ($homebrew_prefix/bin/brew shellenv)

        if test -d "$homebrew_prefix/opt/uutils-coreutils/libexec/uubin"
            set -gx PATH "$homebrew_prefix/opt/uutils-coreutils/libexec/uubin" $PATH
        end

        if test -d "$homebrew_prefix/opt/uutils-findutils/libexec/uubin"
            set -gx PATH "$homebrew_prefix/opt/uutils-findutils/libexec/uubin" $PATH
        end
    end

    # Add Go binaries to PATH if directory exists
    if test -d "$HOME/go/bin"
        set -gx PATH "$HOME/go/bin" $PATH
    end

    # Set TERM for Ghostty terminal
    if test "$TERM_PROGRAM" = ghostty
        set -gx TERM xterm-256color
    end

    if type -q direnv
        direnv hook fish | source
    end

    if type -q fzf
        fzf --fish | source
    end

    if type -q starship
        starship init fish | source
    end

    if type -q zoxide
        zoxide init fish --cmd cd | source
    end
end
