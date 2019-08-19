FROM archlinux/base

ADD mirrorlist /etc/pacman.d/mirrorlist
RUN pacman -Sy --noconfirm grep archiso sudo wget binutils fakeroot file gcc go patch which

WORKDIR /build
ADD . .

CMD ["./build.sh","-v"]
