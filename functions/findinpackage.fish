function findinpackage
    set BR (set_color --bold red)
    set BG (set_color --bold green)
    set B (set_color blue)
    set BB (set_color --bold blue)
    set BY (set_color --bold yellow)
    set RESET (set_color normal)
    # set package_name (pacman -F --machinereadable "/usr/bin/$argv[1]" "/usr/lib/$argv[1]" "/usr/lib32/$argv[1]" 2>/dev/null | awk -F"\0" "{print \$2;exit}")
    set package_name (pacman -F --machinereadable "$argv[1]" 2>/dev/null | awk -F"\0" "{print \$2;exit}")
    if test -z "$package_name"
        printf $BR"Couldn't find the package containing the$B $argv[1]$BR command\n"
        return 1
    end
    printf $BG"File found in the$BY $package_name$BG package.\n"
    read -P "Would you like to install it?$BY [y/n] $RESET" -n 1 confirm
    switch (string lower "$confirm")
        case y
            sudo pacman -S --needed "$package_name"
    end
end
