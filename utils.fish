source /home/$USER/.config/fish/colours.fish

function log
    echo $BW"[INFO] $argv"$RESET
end

function wlog
    echo $BO"[WARN] $argv"$RESET
end

function elog
    echo $BR"[ERROR] $argv"$RESET
end

function ilog
    echo $BG"[INFO] $argv"$RESET
end

function try
    log "Running command => `$BY$argv$RESET`"
    eval "$argv" || \
        { elog "Command failed! Exiting." && return 1 }
    return 0
end

function ask
    read search -P $BW"$argv$BY [y/N]$BB ➜$BR "
    switch (string lower "$search")
        case y
            return 0
        case '*'
            return 1
    end    
end
