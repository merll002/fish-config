function snapshot
    source /home/$USER/.config/fish/colours.fish
    source /home/$USER/.config/fish/utils.fish
    set date (date +%d-%m-%Y)
    if test -d /.snapshots/"$date"
        echo $BR"Snapshot already created today.$BY Exiting."
        return 0
    end
    log "Creating snapshot..."
    ask "Create snapshot?" && try "sudo btrfs subvolume snapshot -r / /.snapshots/\"$date\"" || return 1
    slog "Successfully created snapshot!"
    return 0
end
