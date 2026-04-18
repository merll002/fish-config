function docker
    if test (count $argv) = 2; and test $argv[1] = compose; and test $argv[2] = up
        wlog "Attatching interactively! (press enter) "
        read
    end
    command docker $argv
end
