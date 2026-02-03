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
    ratemirrors
    flatpak update -y
    if /bin/pacman -Qu | grep -q plasma
        set rebuild true
    end
    paru -Syu --batchinstall --cleanafter
    if set -q rebuild
        paru -S --rebuild --noconfirm kwin-effects-glass-git
    end
end




# Organised Fish Shell Aliases

## Prevent completion for my alias
complete -e rm

bind ctrl-l 'clear;fish_prompt'

alias fixzlib='i zlib lib32-zlib'

## Wacom Stuff
alias wacom='xsetwacom --set "Wacom Bamboo 2FG 4x5 Pen stylus" Button 2 pan && xsetwacom --set "Wacom Bamboo 2FG 4x5 Pen stylus"  "PanScrollThreshold" 200'
alias enablewacom='systemctl --user stop opentabletdriver.service && sudo modprobe -i wacom && sleep 1 && xsetwacom --set "Wacom Bamboo 2FG 4x5 Pen stylus" Button 2 pan && xsetwacom --set "Wacom Bamboo 2FG 4x5 Pen stylus"  "PanScrollThreshold" 200'
alias disablewacom='sudo modprobe -r wacom && systemctl --user start opentabletdriver.service'

## Flatpak

alias fr='flatpak remove'
alias fs='flatpak search'
alias frd='flatpak remove --delete-data'
alias fi='flatpak install'
alias fu='flatpak update'
alias fl='flatpak list'
alias spotify-update="flatpak mask --remove com.spotify.Client && flatpak update com.spotify.Client -y && flatpak mask com.spotify.Client"

## File and Directory Management
alias mkdir='mkdir -p'

alias cat='bat'
alias ks='eza --icons=always --classify'
alias sl='eza --icons=always --classify'
alias ls='eza --icons=always --classify'
alias la='eza --icons=always --classify -lA'
alias tree='eza --icons=always --classify -T'
alias fd='echo Use$BY fdf$RESET for finding files and$BY fdd$RESET for finding folders.'
alias of='fzf -e --walker=file --query'
alias fdd='fzf -e --walker=dir --query'
alias fdf='kitten choose-files  --mode=file'

## Command Substitutions
alias nano='micro'
alias rlk='/bin/readlink -f'
alias pip='uv pip'
alias pip3='uv pip'
alias less='less -R'
alias grc='grc --colour=on'
alias blkid='grc blkid'

## System Utilities
alias dmount='udisksctl mount -b'
alias dumount='udisksctl unmount -b'
alias restartghostty='killall ghostty'
alias gc='git clone -j$(nproc) --depth 1'
alias nameof='ps -o comm= -p'
alias fixpass='faillock --user leo --reset'
alias gpupowersave='echo low | sudo tee /sys/class/drm/card1/device/power_dpm_force_performance_level'
alias gpupower='echo auto | sudo tee /sys/class/drm/card1/device/power_dpm_force_performance_level'
if test $TERM = xterm-kitty;
    alias ssh='kitten ssh'
end
alias df='dysk -c+uuid'

## Miscellaneous
alias aliases='micro ~/.config/fish/conf.d/config.fish'
alias sctl='/usr/bin/systemctl'
alias fixkvm='sudo rmmod kvm_amd && sudo rmmod kvm'
alias getclass="/usr/lib/qt6/bin/qdbus org.kde.KWin /KWin org.kde.KWin.queryWindowInfo | grep -E 'resourceName|resourceClass'"
alias unlock='faillock --user leo --reset'
alias penv="if test -d .venv; else; uv venv ; end && source .venv/bin/activate.fish"
alias refreshdrive="yes '' | sudo rclone config reconnect GoogleDriveILike: && yes '' | sudo rclone config reconnect GoogleDriveSnale: && yes '' | sudo rclone config reconnect GoogleDriveAppleID:"

## Environment Variables
set -gx EDITOR /usr/bin/micro
set -gx PATH $PATH:

zoxide init fish --cmd cd | source

fzf --fish | source

## Alternatives!
alias unzip="alternatives ouch unzip"
alias tar="alternatives ouch tar"
alias readlink='alternatives rlk readlink'
alias getpath='echo -e $BG"Use$BY rlk$BG instead."'

## Package Management

if string match -q $distro arch
    alias i='paru -Sy --needed'
    alias u='upgrade'
    alias unoconfirm="ratemirrors && flatpak update -y && paru -Syu --noconfirm --overwrite='*' && paru -S --rebuild --noconfirm kwin-effects-forceblur"
    alias um='paru -Sy'
    alias upgradethenshutdown="sudo su -c 'flatpak update -y && paru -Syu --noconfirm && shutdown now'"
    alias r='paru -Rncs'
    alias ss='pacman -Q | grep'
    alias pacman='paru'
    alias ratemirrors='sudo cachyos-rate-mirrors'
    alias ratemirrorsbad='rate-mirrors --entry-country=UK --max-jumps=1 --country-neighbors-per-country=1 --country-test-mirrors-per-country=6 --disable-comments-in-file --protocol=https arch --max-delay 5200 | sudo tee /etc/pacman.d/mirrorlist && um'

else if string match -q $distro debian
    alias i='sudo apt install'
    alias r='sudo apt purge --autoremove'
    alias u='sudo apt update && sudo apt upgrade && flatpak update'
    alias um'sudo apt update'
    alias upgradethenshutdown="sudo su -c 'apt update && apt upgrade -y && shutdown now'"
    alias s='apt search'
    alias ss='apt list --installed | grep'
    alias bat='batcat'
    alias fd='fdfind'

else if string match -q $distro fedora
    alias i='sudo dnf install'
    alias r='sudo dnf remove'
    alias u='sudo dnf upgrade --refresh'
    alias upgradethenshutdown="sudo su -c 'flatpak update -y && dnf upgrade --refresh && shutdown now'"
    alias s='dnf search'
    alias ss='dnf list --installed | grep'

else if string match -q $distro alpine
    alias i='sudo apk add'
    alias r='sudo apk del'
    alias u='sudo apk upgrade'
    alias upgradethenshutdown="sudo su -c 'flatpak update -y && apk upgrade && shutdown now'"
    alias s='apk search'

else if string match -q $distro gentoo
    alias i='sudo emerge -av'
    alias ib='sudo emerge -avg --binpkg-respect-use=y'
    alias ibq='sudo emerge -avgq --binpkg-respect-use=y'
    alias iq='sudo emerge -avq'
    alias r='sudo emerge -cav'
    alias u='sudo emaint --auto sync && emerge --ask --verbose --update --deep --changed-use @world'
end

source /home/$USER/.config/fish/functions/sudo.fish

end

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /home/leo/.lmstudio/bin
# End of LM Studio CLI section
pyenv init - fish | source
