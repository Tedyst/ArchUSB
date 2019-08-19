FROM archlinux/base

ADD mirrorlist /etc/pacman.d/mirrorlist
RUN pacman -Sy --noconfirm grep archiso sudo wget binutils fakeroot file gcc go git

WORKDIR /build
ADD . .
RUN mv repos/ /home/tedy/repos/

CMD ["./build.sh","-v"]
