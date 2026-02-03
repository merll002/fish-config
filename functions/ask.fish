function ask
    source /home/$USER/.config/fish/colours.fish
    read search -P $BG"$argv$BY [y/N]$BB ➜$BR "
    switch (string lower "$search")
        case y
            return 0
        case '*'
            return 1
    end    
end
