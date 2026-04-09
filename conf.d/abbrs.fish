if status is-interactive
abbr -a -- fixzlib 'i zlib lib32-zlib'

## Wacom Stuff
abbr -a -- wacom 'xsetwacom --set "Wacom Bamboo 2FG 4x5 Pen stylus" Button 2 pan && xsetwacom --set "Wacom Bamboo 2FG 4x5 Pen stylus"  "PanScrollThreshold" 200'
abbr -a -- enablewacom 'systemctl --user stop opentabletdriver.service && sudo modprobe -i wacom && sleep 1 && xsetwacom --set "Wacom Bamboo 2FG 4x5 Pen stylus" Button 2 pan && xsetwacom --set "Wacom Bamboo 2FG 4x5 Pen stylus"  "PanScrollThreshold" 200'
abbr -a -- disablewacom 'sudo modprobe -r wacom && systemctl --user start opentabletdriver.service'

## Flatpak
abbr -a -- fr 'flatpak remove'
abbr -a -- fs 'flatpak search'
abbr -a -- frd 'flatpak remove --delete-data'
abbr -a -- fi 'flatpak install'
abbr -a -- fu 'flatpak update'
abbr -a -- fl 'flatpak list'
abbr -a -- spotify-update "flatpak mask --remove com.spotify.Client && flatpak update com.spotify.Client -y && flatpak mask com.spotify.Client"

## File and Directory Management
abbr -a -- mkdir 'mkdir -p'

abbr -a -- cat 'bat'
# Them expanding is annoying
alias ls='eza --icons always --classify'
alias ks='eza --icons always --classify'
alias sl='eza --icons always --classify'
alias la='eza --icons always --classify -lA'
alias tree='eza --icons always --classify -T'
alias of='fzf -e --walker file'
alias fdd='fzf -e --walker dir'
alias fdf='kitten choose-files --mode file'

## Command Substitutions
abbr -a -- nano 'micro'
abbr -a -- rlk '/bin/readlink -f'
abbr -a -- pip 'uv pip'
abbr -a -- pip3 'uv pip'
abbr -a -- less 'less -R'
abbr -a -- grc 'grc --colour on'
abbr -a -- blkid 'grc blkid'
abbr -a -- somo 'sonar'
abbr -a -- rg 'rga-fzf'
abbr -a -- dua 'cull'
abbr -a -- lsblk 'lsblk -o NAME,SIZE,LABEL,MOUNTPOINTS'

## git substitutions
abbr -a -- g 'git'
abbr -a -- gpl 'git pull'
abbr -a -- gps 'git push'
abbr -a -- gf 'git fetch'
abbr -a -- gl 'git log'
abbr -a -- ga 'git add'
abbr -a -- gs 'git status'
abbr -a -- gd 'git diff'
abbr -a -- gc 'git clone -j$(nproc) --depth 1'
abbr gcm --set-cursor=! 'git commit -am "!"'
abbr -a -- grm 'git rm --cached'


## System Utilities
abbr -a -- dmount 'udisksctl mount -b'
abbr -a -- dumount 'udisksctl unmount -b'
abbr -a -- restartghostty 'killall ghostty'
abbr -a -- nameof 'ps -o comm -p'
abbr -a -- fixpass 'faillock --user leo --reset'
abbr -a -- gpupowersave 'echo low | sudo tee /sys/class/drm/card1/device/power_dpm_force_performance_level'
abbr -a -- gpupower 'echo auto | sudo tee /sys/class/drm/card1/device/power_dpm_force_performance_level'
test $TERM = xterm-kitty && abbr -a -- ssh 'TERM=xterm-256color kitten ssh -C'
abbr -a -- df 'dysk -c+uuid'

## Miscellaneous
abbr -a -- aliases 'micro ~/.config/fish/conf.d/abbrs.fish'
abbr -a -- sctl '/usr/bin/systemctl'
abbr -a -- fixkvm 'sudo rmmod kvm_amd && sudo rmmod kvm'
abbr -a -- getclass "qdbus6 org.kde.KWin /KWin org.kde.KWin.queryWindowInfo | grep -E 'resourceName|resourceClass'"
abbr -a -- unlock 'faillock --user leo --reset'
abbr -a -- penv "if test -d .venv; else; uv venv -p 3.14 ; end && source .venv/bin/activate.fish"
abbr -a -- resource "source ~/.config/fish/conf.d/config.fish"


## Alternatives!
abbr -a -- unzip "alternatives ouch unzip"
abbr -a -- tar "alternatives ouch tar"
abbr -a -- du "alternatives cull du"

## Package Management

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

if string match -q $distro arch
    abbr -a -- i 'paru -Sy --needed'
    abbr -a -- u 'upgrade'
    abbr -a -- um 'paru -Sy'
    abbr -a -- r 'paru -Rncs'
    abbr -a -- ss 'pacman -Q | grep'
    abbr -a -- pacman 'paru'
    abbr -a -- ratemirrors 'sudo cachyos-rate-mirrors'
    abbr -a -- ratemirrorsbad 'rate-mirrors --entry-country UK --max-jumps 1 --country-neighbors-per-country 1 --country-test-mirrors-per-country 6 --disable-comments-in-file --protocol https arch --max-delay 5200 | sudo tee /etc/pacman.d/mirrorlist && um'
else if string match -q $distro debian
    abbr -a -- i 'sudo apt install'
    abbr -a -- r 'sudo apt purge --autoremove'
    abbr -a -- u 'sudo apt update && sudo apt upgrade && flatpak update'
    abbr -a -- um'sudo apt update'
    abbr -a -- upgradethenshutdown "sudo su -c 'apt update && apt upgrade -y && shutdown now'"
    abbr -a -- s 'apt search'
    abbr -a -- ss 'apt list --installed | grep'
    abbr -a -- bat 'batcat'
    abbr -a -- fd 'fdfind'
else if string match -q $distro fedora
    abbr -a -- i 'sudo dnf install'
    abbr -a -- r 'sudo dnf remove'
    abbr -a -- u 'sudo dnf upgrade --refresh'
    abbr -a -- upgradethenshutdown "sudo su -c 'flatpak update -y && dnf upgrade --refresh && shutdown now'"
    abbr -a -- s 'dnf search'
    abbr -a -- ss 'dnf list --installed | grep'
else if string match -q $distro alpine
    abbr -a -- i 'sudo apk add'
    abbr -a -- r 'sudo apk del'
    abbr -a -- u 'sudo apk upgrade'
    abbr -a -- upgradethenshutdown "sudo su -c 'flatpak update -y && apk upgrade && shutdown now'"
    abbr -a -- s 'apk search'
else if string match -q $distro gentoo
    abbr -a -- i 'sudo emerge -av --keep-going=y --noreplace --autounmask'
    abbr -a -- ib 'sudo emerge -avg --binpkg-respect-use=y --keep-going=y --noreplace --autounmask'
    abbr -a -- ibq 'sudo emerge -avgq --binpkg-respect-use=y --keep-going=y --noreplace --autounmask'
    abbr -a -- iq 'sudo emerge -avq --keep-going=y --noreplace --autounmask'
    abbr -a -- r 'echo "Use rd to deselect them, then rr to depclean."'
    abbr -a -- rd 'sudo emerge --deselect'
    abbr -a -- rr 'sudo emerge -cav'
    abbr -a -- s 'eix'
    abbr -a -- u 'read -P "You should sync (um) first" && sudo emerge --ask --verbose --update --deep --changed-use --with-bdeps=y @world --keep-going=y && sudo emerge -av --depclean'
    abbr -a -- um 'sudo emaint --auto sync'
end
end
