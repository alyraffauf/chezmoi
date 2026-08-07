status is-interactive; or return

if type -q direnv
    direnv hook fish | source
end

if type -q fzf
    fzf --fish | source
end

if type -q atuin
    atuin init fish --disable-up-arrow | source
end

if type -q nix-your-shell
    nix-your-shell fish | source
end

if type -q starship
    starship init fish | source
end

if type -q zoxide
    zoxide init fish --cmd cd | source
end
