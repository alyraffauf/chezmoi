# shellcheck shell=sh

# ~/.profile
#
# Login/session-wide environment.
# Keep interactive shell configuration in the shell-specific config
# (~/.config/fish/config.fish, ~/.bashrc, etc.).

# Add a directory to the front of PATH, removing existing entries first.
path_prepend() {
    [ -d "$1" ] || return

    path_dir=$1
    previous_ifs=$IFS
    IFS=:
    # shellcheck disable=SC2086
    set -- $PATH
    IFS=$previous_ifs

    PATH=$path_dir
    for existing_path_dir; do
        [ "$existing_path_dir" = "$path_dir" ] && continue
        PATH="$PATH:$existing_path_dir"
    done

    unset path_dir previous_ifs existing_path_dir
}

# Nix daemon environment
if [ -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]; then
    . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi

# Homebrew
#
# Linux:        /home/linuxbrew/.linuxbrew
# Apple Silicon: /opt/homebrew
# Intel macOS:   /usr/local
if [ -x /home/linuxbrew/.linuxbrew/bin/brew ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi

# uutils installed through Homebrew
if command -v brew >/dev/null 2>&1; then
    brew_prefix=$(brew --prefix)

    path_prepend "$brew_prefix/opt/uutils-coreutils/libexec/uubin"
    path_prepend "$brew_prefix/opt/uutils-findutils/libexec/uubin"

    unset brew_prefix
fi

# User-installed development tools
path_prepend "$HOME/.nix-profile/bin"
path_prepend "$HOME/go/bin"
path_prepend "$HOME/.local/bin"
path_prepend "$HOME/bin"
path_prepend "$HOME/.bun/bin"
path_prepend "$HOME/.cargo/bin"
path_prepend "$HOME/.local/share/pnpm"
path_prepend "$HOME/.deno/bin"
path_prepend "$HOME/.volta/bin"
path_prepend "$HOME/.npm-global/bin"

export PATH

unset -f path_prepend 2>/dev/null || true
