function repo_update_check
    source /home/$USER/.config/fish/colours.fish
    set repos (cat ~/.config/repos.conf)
    for repo in $repos
        if test (cat /tmp/last_fetch) != (date +%d)
            git -C "$repo" fetch &
            echo (date +%d) > /tmp/last_fetch
        end
        set branch (git -C "$repo" branch | tr -d '* ')
        set behind (git -C "$repo" rev-list --count HEAD..origin/"$branch")
        set ahead (git -C "$repo" rev-list --count origin/"$branch"..HEAD)
        set unstaged (git -C "$repo" status --porcelain | wc -l)
        set name (basename (git -C "$repo" remote get-url origin))
        set msg "Repo$BY $name$RESET:"
        if test $behind = 0 -a $ahead = 0 -a $unstaged = 0
            continue
        end
        if test $behind -gt 0
            set msg "$msg$BY $behind$RESET$BR behind$RESET"
        end
        if test $ahead -gt 0
            set msg "$msg$BY $ahead$RESET$BG ahead$RESET"
        end
        if test $unstaged -gt 0
            set msg "$msg$BY $unstaged$BC unstaged$RESET"
        end
        echo "$msg"
    end
end
