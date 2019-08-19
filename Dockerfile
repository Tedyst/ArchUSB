FROM archlinux/base

ADD mirrorlist /etc/pacman.d/mirrorlist
RUN pacman -Sy --noconfirm grep archiso sudo wget binutils

WORKDIR /build
ADD . .

# CMD cat /etc/sudoers
CMD ["./build.sh","-v"]
