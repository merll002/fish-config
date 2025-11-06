function sudo
    if functions -q -- $argv[1]
        set -- argv -- fish -C "$(functions --no-details -- $argv[1])" -c '$argv' -- $argv
    end
    
    command sudo $argv
end
