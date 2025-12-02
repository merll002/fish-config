function rn
    set BY (set_color --bold yellow)
    set RESET (set_color normal)
    set newpath (string replace -rf '/[^/]+(/$|$)' '/' -- $argv[1] || echo ./)$argv[2]
    read -P "Rename $argv[1] to $newpath?$BY [y/n] $RESET" -n 1 search
    if string match -q (string lower "$search") "y"
        mv $argv[1] $newpath
    end
end
