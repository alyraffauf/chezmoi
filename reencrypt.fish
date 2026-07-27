#!/usr/bin/env fish

set -l chezmoi_dir ~/.local/share/chezmoi
cd $chezmoi_dir || exit 1

# Extract the recipients array from .chezmoi.toml.tmpl.
# This handles literal TOML string arrays; it will not render Go template expressions.
set -l recipients (
    awk '/recipients = \[/,/\]/' .chezmoi.toml.tmpl |
    awk '/^[[:space:]]+"/ { sub(/^[[:space:]]+"/, ""); sub(/",?$/, ""); print }'
)

if test (count $recipients) -eq 0
    echo "No recipients found in .chezmoi.toml.tmpl" >&2
    exit 1
end

echo "Recipients found:"
for r in $recipients
    echo "  - $r"
end

set -l age_files (find . -name '*.age')
if test (count $age_files) -eq 0
    echo "No .age files found." >&2
    exit 0
end

for f in $age_files
    set -l tmp (mktemp)
    echo "Re-encrypting $f ..."

    age -d $f > $tmp
    if test $status -ne 0
        echo "Failed to decrypt $f" >&2
        rm $tmp
        exit 1
    end

    rm $f

    set -l age_args -e -o $f
    for r in $recipients
        set -a age_args -r $r
    end
    set -a age_args $tmp

    age $age_args
    if test $status -ne 0
        echo "Failed to encrypt $f" >&2
        rm $tmp
        exit 1
    end

    rm $tmp
end

echo "Done."
