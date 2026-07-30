status is-interactive; or return

if test -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
    source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
end

set -l homebrew_prefix

if test -x /home/linuxbrew/.linuxbrew/bin/brew
    set homebrew_prefix /home/linuxbrew/.linuxbrew
else if test -x /opt/homebrew/bin/brew
    set homebrew_prefix /opt/homebrew
end

if test -n "$homebrew_prefix"
    eval ($homebrew_prefix/bin/brew shellenv)

    if test -d "$homebrew_prefix/opt/uutils-coreutils/libexec/uubin"
        fish_add_path --global --prepend --move "$homebrew_prefix/opt/uutils-coreutils/libexec/uubin"
    end

    if test -d "$homebrew_prefix/opt/uutils-findutils/libexec/uubin"
        fish_add_path --global --prepend --move "$homebrew_prefix/opt/uutils-findutils/libexec/uubin"
    end
end

for path_dir in \
    "$HOME/.nix-profile/bin" \
    "$HOME/go/bin" \
    "$HOME/.local/bin" \
    "$HOME/.bun/bin" \
    "$HOME/.cargo/bin" \
    "$HOME/.local/share/pnpm" \
    "$HOME/.deno/bin"
    test -d "$path_dir"; and fish_add_path --prepend --move "$path_dir"
end

if command -q nix-your-shell
    nix-your-shell fish | source
end
