function capture
    argparse -u -- $argv
    switch "$argv_opts"
        case -s
            set sudo sudo
        case ""
        case "*"
            echo "Usage: capture [-s sudo] <command>"
            return 0
    end
    eval $sudo (which termframe) --timeout 120 --width auto --height auto -o /tmp/image.svg --show-command --font-family 'Maple Mono' -W 100 --theme Afterglow --window-style compact -- $argv 2>/dev/null
    rsvg-convert /tmp/image.svg | wl-copy -t image/png
    asktry sudo /bin/rm /tmp/image.svg
end
