source /usr/share/cachyos-fish-config/cachyos-config.fish
# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end


if status is-interactive


# Organised Fish Shell Aliases

## Prevent completion for my alias
complete -e rm


set BR (set_color --bold red)
set BG (set_color --bold green)
set B (set_color blue)
set BB (set_color --bold blue)
set BY (set_color --bold yellow)
set RESET (set_color normal)

## Wacom Stuff

alias wacom='xsetwacom --set "Wacom Bamboo 2FG 4x5 Pen stylus" Button 2 pan && xsetwacom --set "Wacom Bamboo 2FG 4x5 Pen stylus"  "PanScrollThreshold" 200'
alias enablewacom='systemctl --user stop opentabletdriver.service && sudo modprobe -i wacom && sleep 1 && xsetwacom --set "Wacom Bamboo 2FG 4x5 Pen stylus" Button 2 pan && xsetwacom --set "Wacom Bamboo 2FG 4x5 Pen stylus"  "PanScrollThreshold" 200'
alias disablewacom='sudo modprobe -r wacom && systemctl --user start opentabletdriver.service'

## Package Management

# Arch-based
alias i='paru -S --needed'
alias u='flatpak update && paru -Syu'
alias um='paru -Sy'
alias upgradethenshutdown="su -c 'flatpak update && paru -Syu' leo && shutdown now"
alias r='paru -Rncs'
alias ss='pacman -Q |grep'
alias pacman='paru'
alias ratemirrors='rate-mirrors --disable-comments-in-file --protocol=https arch --max-delay 5200 | sudo tee /etc/pacman.d/mirrorlist && um'


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
# alias rm='echo Use trash-put instead or use sudo.'
alias cat='bat'
alias ks='eza --icons=always --classify'
alias sl='eza --icons=always --classify'
alias ls='eza --icons=always --classify'
alias la='eza --icons=always --classify -lA'
alias tree='eza --icons=always --classify -T'
alias fd='echo Use$BY fdf$RESET for finding files and$BY fdd$RESET for finding folders.'
alias fdf='fzf -e --walker=file --query'
alias fdd='fzf -e --walker=dir --query'
alias of='xdg-open (kitten choose-files  --mode=file)'

## Command Substitutions
alias nano='micro'
alias getpath='readlink -f'
alias rlk='readlink -f'
alias pip='uv pip'
alias pip3='uv pip'

## System Utilities
alias dmount='udisksctl mount -b'
alias dumount='udisksctl unmount -b'
alias restartghostty='killall ghostty'
alias gc='git clone -j$(nproc) --depth 1'
alias nameof='ps -o comm= -p'
alias fixpass='faillock --user leo --reset'
alias gpupowersave='echo low | sudo tee /sys/class/drm/card1/device/power_dpm_force_performance_level'
alias gpupower='echo auto | sudo tee /sys/class/drm/card1/device/power_dpm_force_performance_level'
alias ssh='kitten ssh'
alias df='dysk -c+uuid'

## Miscellaneous
alias sudo='sudo '
alias aliases='nano ~/.config/fish/config.fish'
alias sctl='/usr/bin/systemctl'
alias fixkvm='sudo rmmod kvm_amd && sudo rmmod kvm'
alias getclass="/usr/lib/qt6/bin/qdbus org.kde.KWin /KWin org.kde.KWin.queryWindowInfo | grep -E 'resourceName|resourceClass'"
alias unlock='faillock --user leo --reset'
alias penv="if test -d .venv; else; uv venv ; end && source .venv/bin/activate.fish"

## Environment Variables
set -gx EDITOR /usr/bin/micro
set -gx PATH $PATH:

starship init fish | source

zoxide init fish --cmd cd | source

fzf --fish | source


cmd=(/bin/cat /etc/os-release|grep PRETTY_NAME) if test $cmd = 'PRETTY_NAME="CachyOS"'
    true
else
    alias i='sudo apt install'
    alias r='sudo apt purge'
    alias u='sudo apt update && sudo apt upgrade && flatpak update'
    alias s='apt search'
    alias ss='apt list --installed|grep'
    alias cat='batcat'
    set TERM xterm
end


## Alternatives!
alias unzip="alternatives ouch unzip"
alias tar="alternatives ouch tar"

source /home/leo/.config/fish/functions/sudo.fish


end

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /home/leo/.lmstudio/bin
# End of LM Studio CLI section

