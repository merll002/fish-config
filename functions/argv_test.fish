function argv_test
    for i in (seq (count $argv))
        echo "Arg $i: $argv[$i]"
    end
end
