#!/bin/bash

set -e -u

sed -i 's/#\(en_US\.UTF-8\)/\1/' /etc/locale.gen
locale-gen

ln -sf /usr/share/zoneinfo/UTC /etc/localtime

usermod -s /usr/bin/zsh root
cp -aT /etc/skel/ /root/
chmod 700 /root

sed -i 's/#\(PermitRootLogin \).\+/\1yes/' /etc/ssh/sshd_config
sed -i "s/#Server/Server/g" /etc/pacman.d/mirrorlist
sed -i 's/#\(Storage=\)auto/\1volatile/' /etc/systemd/journald.conf

sed -i 's/#\(HandleSuspendKey=\)suspend/\1poweroff/' /etc/systemd/logind.conf
sed -i 's/#\(HandleHibernateKey=\)hibernate/\1poweroff/' /etc/systemd/logind.conf
sed -i 's/#\(HandleLidSwitch=\)suspend/\1poweroff/' /etc/systemd/logind.conf
sed -i 's/#\(HandlePowerKey=\)poweroff/\1poweroff/' /etc/systemd/logind.conf

systemctl enable sddm.service
systemctl set-default graphical.target

# Password is "password"
useradd -p cojkMmMifD5s6 tedy
chown tedy -R /home/tedy/

sudo -u tedy /home/tedy/autostart.sh

# # Installing vscode extensions
# sudo -u tedy code --install-extension aaron-bond.better-comments
# sudo -u tedy code --install-extension chiehyu.vscode-astyle
# sudo -u tedy code --install-extension coenraads.bracket-pair-colorizer
# sudo -u tedy code --install-extension pkief.material-icon-theme
# sudo -u tedy code --install-extension zhuangtongfa.material-theme
# sudo -u tedy code --install-extension alefragnani.project-manager
# sudo -u tedy code --install-extension ms-vscode.atom-keybindings
# sudo -u tedy code --install-extension oderwat.indent-rainbow

# LATEST_CPP=$(curl --silent "https://api.github.com/repos/Microsoft/vscode-cpptools/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
# CPP_LINK="https://github.com/microsoft/vscode-cpptools/releases/download/$LATEST_CPP/cpptools-linux.vsix"
# wget -O /home/tedy/cpptools-linux.vsix $CPP_LINK
# sudo -u tedy code --install-extension /home/tedy/cpptools-linux.vsix
# rm -f /home/tedy/cpptools-linux.vsix

# Set default browser is bugged right now, crashes w/ Segfault
# sudo -u tedy firefox-esr --silent --headless --setDefaultBrowser

