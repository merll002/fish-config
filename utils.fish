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

function slog
    echo $BG"[INFO] $argv"$RESET
end

function try
    log "Running command => $argv$RESET"
    eval "$argv" || \
        { elog "Command failed! Exiting." && return 1 }
    return 0
end
