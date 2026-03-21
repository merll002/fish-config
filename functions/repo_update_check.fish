function repo_update_check
    source /home/$USER/.config/fish/colours.fish
    set repos (cat ~/.config/repos.conf)
    for repo in $repos
        set branch (git -C "$repo" branch | tr -d '* ')
        set behind (git -C "$repo" rev-list --count HEAD..origin/"$branch")
        set ahead (git -C "$repo" rev-list --count origin/"$branch"..HEAD)
        set name (basename (git -C "$repo" remote get-url origin))
        set msg "Repo$BY $name$RESET is"
        if test $behind = 0 -a $ahead = 0
            continue
        else if test $behind > 0 -a $ahead > 0
            set msg "$msg$BR behind$RESET by$BY $behind$RESET commits and$BG ahead$RESET by$BY $ahead$RESET commits."
        else if test $behind > 0 -a $ahead = 0
            set msg "$msg$BR behind$RESET by$BY $behind$RESET commits."
        else if test $behind = 0 -a $ahead > 0
            set msg "$msg$BG ahead$RESET by$BY $ahead$RESET commits."
        end
        echo "$msg"
    end
end
