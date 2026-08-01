# Keep interactive terminals at the logical Fedora Atomic home path.
if status is-interactive; and test "$PWD" = "/var/home/aly"
    builtin cd "$HOME"
end
