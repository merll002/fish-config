function ask
    read search -P $BW"$argv$BY [y/N]$BB ➜$BR "
    switch (string lower "$search")
        case y
            return 0
        case '*'
            return 1
    end    
end
