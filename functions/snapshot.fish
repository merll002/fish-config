function snapshot
    source /home/$USER/.config/fish/colours.fish
    set date (date +%d-%m-%Y)
    if test -d /.snapshots/"$date"
        log "Snapshot already created today. Exiting."
        return 0
    end
    log "Creating snapshot..."
    ask "Create snapshot?" && try "sudo btrfs subvolume snapshot -r / /.snapshots/\"$date\"" || return 1
    slog "Successfully created snapshot!"
    return 0
end
