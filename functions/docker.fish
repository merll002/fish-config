function docker
    if test (count $argv) = 2; and test $argv[1] = compose; and test $argv[2] = up
        wlog "Attatching interactively! (press enter) "
        read || return 1
    end
    command docker $argv
end
