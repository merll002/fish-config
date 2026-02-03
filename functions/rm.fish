function rm
    source /home/$USER/.config/fish/functions/ask.fish
    set BR (set_color --bold red)
    set BY (set_color --bold yellow)
    set BG (set_color --bold green)
    set BC (set_color --bold cyan)
    set RESET (set_color normal)

    if test (whoami) = root
        set command 'sudo /bin/rm'
    else
        set command '/bin/rm'
    end
    
    if test (which fd) >/dev/null 2>&1
        set fd (which fd)
    else
        set fd /bin/fdfind
    end 

    argparse -u -- $argv

    for f in $argv
        set args "$args" \""$f"\"
    end
    

    function delete
        set BC (set_color --bold cyan)
        set BR (set_color --bold red)
        echo -e $BC"Deleting files with command:$BR $argv"
        if ask "Continue?"
            eval $argv --one-file-system
        end
        return 0
    end

    set ok 1
    for f in $argv
        if not test -f "$f"
            set ok 0
        end
        if not test -e "$f"
            echo "$BC$f$BY does$BR not$BY exist"
            return 1
        end
        if not test -w (dirname "$f"); and not test -d "$f"
            set bad_files $bad_files "$f"
        end 
    end
    if not test -z $bad_files
        read search -P $BY"You dont have permission to delete these files: $bad_files. Use sudo? [y/N]$BG "
        switch (string lower "$search")
            case y
                set command 'sudo /bin/rm'
            case '*'
                return 1
        end
    end

    if test $ok -eq 1
        delete $command $argv_opts $args
        return 0
    end

    for f in $args
        # Check if the argument is a mount point using findmnt
        if test -z $f # If array element is empty
            continue
        end
        
        set mounts (cut -d' ' -f2 /proc/mounts | grep (string replace '"' '' "$f" -a))
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
    eval $fd -H -t f -0 . "$args" | while read -l -z file
        set count (math $count + 1)
        printf "\rNumber of files: %d %s" $count $extra
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
    echo -e $BY"$count file(s)!"
    delete $command $argv_opts $args
end
