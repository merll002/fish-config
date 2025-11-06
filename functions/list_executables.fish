function list_executables
    if test (count $argv) -ne 1
        echo "Usage: list_executables <package>"
        return 1
    end
    
    pacman -Ql $argv[1] | awk '{print $2}' | while read -l file
        if test -x "$file" && test -f "$file" && not string match -q '*.so*' "$file"
            echo "$file"
        end
    end
end
