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
systemctl enable NetworkManager.service
systemctl set-default graphical.target

# Password is "password"
useradd -p cojkMmMifD5s6 tedy
chown tedy -R /home/tedy/

# Install oh-my-zsh
sudo -u tedy sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
sudo -u tedy git clone https://github.com/Tedyst/zsh.git --recurse-submodules
sudo -u tedy /home/tedy/zsh/install.sh
