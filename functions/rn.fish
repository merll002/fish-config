function rn
    source /home/$USER/.config/fish/utils.fish
    source /home/$USER/.config/fish/colours.fish
    set newpath (string replace -rf '/[^/]+(/$|$)' '/' -- $argv[1] || echo ./)$argv[2]
    if ask "Rename $argv[1] to $newpath?"
        mv -v $argv[1] $newpath
    end
end
