function rm

    set BR (set_color --bold red)
    set BY (set_color --bold yellow)
    set BG (set_color --bold green)
    set BC (set_color --bold cyan)
    set RESET (set_color normal)

    for f in $argv
        if not string match -qr "^-\S*" -- "$f"
            set args $args $f
        else if string match -qr "^-\S*" -- "$f"
            set params $params $f
        else
            echo "Weird arguments given. Please invoke rm by path (/bin/rm)"
        end
    end
    set ok 1
    for f in $args
        if not test -f "$f"
            set ok 0
        end
        if not test -e "$f"
            echo "$BC$f$BY does$BR not$BY exist"
            return 1
        end
    end
    
    if test $ok -eq 1
        echo -e $BC"Deleting files with command:$BR sudo rm $params $args"
        sudo /bin/rm $params $args
        return 0
    end

    

    for f in $args
        # Check if the argument is a mount point using findmnt
        set mounts (cut -d' ' -f2 /proc/mounts | grep $f)
            if test $status -eq 0
                echo -e $BR"WARNING: Folder contains the following mounts:$BY"
                findmnt / | head -1
                for line in $mounts
                    findmnt -n $line
                end
            end
    end
    
    
    echo -e "$RESET"
    set count 0
    /bin/fd -t f -0 . $args | while read -l -z file
        set count (math $count + 1)
        printf "\r$extra Number of files: %d" $count
        if test $count -eq 5000
            printf '\e[38;2;0;255;0m'
            set extra 😁
        else if test $count -eq 10000
            printf '\e[38;2;32;223;0m'
            set extra 😄
        else if test $count -eq 15000
            printf '\e[38;2;64;191;0m'
            set extra 🙂
        else if test $count -eq 20000
            printf '\e[38;2;96;159;0m'
            set extra 😐
        else if test $count -eq 25000
            printf '\e[38;2;128;127;0m'
            set extra 😕
        else if test $count -eq 30000
            printf '\e[38;2;160;95;0m'
            set extra 🙁
        else if test $count -eq 35000
            printf '\e[38;2;192;63;0m'
            set extra 😟
        else if test $count -eq 40000
            printf '\e[38;2;224;31;0m'
            set extra 😧
        else if test $count -eq 45000
            printf '\e[38;2;255;0;0m'
            set extra 😰
        else if test $count -gt 50000; and test (random 1 100) -eq 1
            if test $extra = '😰'; set extra 😡; end
            if test (random 1 2) -eq 1
                printf '\e[3m'
            else if test (random 1 2) -eq 2
                printf '\e[23m'
            end
        else if test $count -gt 70000; and test (random 1 100) -eq 1
            if test $extra = '😡'; set extra 🤬; end
            if test (random 1 2) -eq 1
                printf '\e[4m'
            else if test (random 1 2) -eq 2
                printf '\e[24m'
            end
        else if test $count -gt 90000; and test (random 1 100) -eq 1
            if test $extra = '🤬'; set extra 👿; end
            if test (random 1 2) -eq 1
                printf '\e[1m'
            else if test (random 1 2) -eq 2
                printf '\e[22m'
            end
        else if test $count -gt 110000; and test (random 1 100) -eq 1
            if test $extra = '👿'; set extra 👿💢; end
            if test (random 1 2) -eq 1
                printf '\e[9m'
            else if test (random 1 2) -eq 2
                printf '\e[29m'
            end
        end
    end
    echo 
    read search -P $BY"Are you sure you want to delete $count files? [y/N]$BG "
    switch (string lower "$search")
        case y
            set continue 1
        case '*'
            return 1
    end
    echo -e $BC"Deleting files with command:$BR sudo rm $params $args"
    read search -P $BY"Continue? [y/N]$BR "
    switch (string lower "$search")
        case y
            set continue 1
        case '*'
            return 1
    end
    sudo /bin/rm $params $args
    return 0
end
