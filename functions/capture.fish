function capture
    termframe --timeout 120 --width auto --height auto -o /tmp/image.svg --show-command --font-family 'Maple Mono' -W 100 --theme 'Afterglow' --window-style compact  -- $argv 2>/dev/null
    rsvg-convert /tmp/image.svg | wl-copy -t image/png
end
