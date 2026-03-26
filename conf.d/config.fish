if status is-interactive

# Fix backwards prompt
set -g fish_key_bindings fish_hybrid_key_bindings

if test (which pacman 2>/dev/null)
    set distro "arch"

else if test (which apt 2>/dev/null)
    set distro "debian"

else if test (which dnf 2>/dev/null)
    set distro "fedora"

else if test (which apk 2>/dev/null)
    set distro "alpine"
    
else if test (which emerge 2>/dev/null)
    set distro "gentoo"
end

function upgrade
    if ! test -e /tmp/mirrorsdone
        ratemirrors &
        touch /tmp/mirrorsdone
    end
    go-global-update &
    cargo install-update -a &
    flatpak update -y
    if /bin/pacman -Qu | grep -q plasma
        set rebuild true
    end
    wait
    paru -Syu --batchinstall --cleanafter
    if set -q rebuild
        paru -S --rebuild --noconfirm kwin-effects-glass-git
    end
end

function upgradeunattended
    if ! test -e /tmp/mirrorsdone
        ratemirrors && touch /tmp/mirrorsdone &
    end
    flatpak update -y &
    go-global-update &
    cargo install-update -a &
    if /bin/pacman -Qu | grep -q plasma
        set rebuild true
    end
    paru -Syu --batchinstall --cleanafter --noconfirm
    if set -q rebuild
        paru -S --rebuild --noconfirm kwin-effects-glass-git
    end
end

function upgradethenshutdown
    upgradeunattended
    sudo systemctl shutdown
end

function upgradethenreboot
    upgradeunattended
    sudo systemctl reboot
end


complete -e rm
complete -e tar
complete -e unzip
complete -e du

bind ctrl-l 'clear;fish_prompt'

if functions -q fish_greeting
    functions --copy fish_greeting original_greeting
    set -U fish_greeting ""
    original_greeting
end
repo_update_check
end

set -gx EDITOR /usr/bin/micro
zoxide init fish --cmd cd | source
fzf --fish | source
