function capture
    termframe -o /tmp/image.svg -W 100 --theme 'Afterglow' --window-style compact  -- $argv
    rsvg-convert /tmp/image.svg | wl-copy -t image/png
end
