function rn
    source /home/$USER/.config/fish/utils.fish
    test -n "$argv[2]" || { elog 'Missing argument'; return 1 }

    set newpath (dirname $argv[1])/$argv[2]
    if ask "Rename $argv[1] to $newpath?"
        mv -v $argv[1] $newpath
    end
end
