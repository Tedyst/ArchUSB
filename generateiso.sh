#!/bin/bash
if [ "$EUID" = 0 ]; then
  echo "Please don't run this script as root!"
  exit
fi
distroversion="1.0.0"
distrocodename="Test"
echo "Welcome to the generation script for 'Tedy'"
echo "==========="
if [ "$1" != "" ]; then
  distroversion="$1"
  distrocodename="$2"
else
  echo -n "Please enter the current version of 'Tedy' > "
  read distroversion
  echo -n "Please enter the current codename of 'Tedy' > "
  read distrocodename
fi
createdir() {
  sudo mkdir workingdir
  sudo cp -r /usr/share/archiso/configs/baseline/* ./workingdir
}
copypackages() {
  sudo cp ./packages ./workingdir/packages.x86_64
}
copyairootfs() {
  sudo mkdir ./workingdir/airootfs
  sudo cp -r airootfs/* ./workingdir/airootfs/
}
createlsbrelease() {
  # echo "lsb-release" | sudo tee --append ./workingdir/packages.x86_64 > /dev/null
  echo "DISTRIB_ID=Tedy" | sudo tee ./workingdir/airootfs/etc/lsb-release > /dev/null
  echo 'DISTRIB_DESCRIPTION="Arch ISO"' | sudo tee --append ./workingdir/airootfs/etc/lsb-release > /dev/null
  echo "DISTRIB_RELEASE=$distroversion" | sudo tee --append ./workingdir/airootfs/etc/lsb-release > /dev/null
  echo "DISTRIB_CODENAME=$distrocodename" | sudo tee --append ./workingdir/airootfs/etc/lsb-release > /dev/null
}
compileaurpkgs() {
  mkdir customrepo
  mkdir customrepo/x86_64
  mkdir customrepo/i686
  mkdir customrepo/custompkgs
  repopath="$(readlink -f .)"
  buildingpath="$(readlink -f ./customrepo/custompkgs)"
  while IFS='' read -r currentpkg || [[ -n "$currentpkg" ]]; do
    cd customrepo/custompkgs
    curl https://aur.archlinux.org/cgit/aur.git/snapshot/$currentpkg.tar.gz > ./currentpkg.tar.gz
    tar xf currentpkg.tar.gz
    rm currentpkg.tar.gz
    cd $currentpkg
    makepkg -s
    cp *.pkg.ta* ../../x86_64
    cd $repopath
  done < "aurpackages"
  # rm -rf customrepo/custompkgs
  unset repopath buildingpath
}
setuprepo() {
  cd customrepo/x86_64
  echo "Adding packages to repository..."
  repo-add customrepo.db.tar.gz *.pkg.ta*
  cd ../..
  sudo sed -i 's/Architecture = auto/Architecture = x86_64/g' ./workingdir/pacman.conf
  echo "[customrepo]" | sudo tee --append ./workingdir/pacman.conf > /dev/null
  echo "SigLevel = Never" | sudo tee --append ./workingdir/pacman.conf > /dev/null
  echo "Server = file://$(pwd)/customrepo/$(echo '$arch')" | sudo tee --append ./workingdir/pacman.conf > /dev/null
}
buildtheiso() {
  sudo rm -rf ./workingdir/airootfs/etc/systemd/system/getty*
  cd workingdir
  sudo ./build.sh -v
  cd ../
}
cleanup() {
  echo "Cleaning up..."
  sudo rm -rf /var/cache/pacman/pkg/archmaker-calamares*
  sudo rm -rf /var/cache/pacman/pkg/qt5-styleplugins-git*
  finalfiles=""
  while IFS='' read -r currentpkg || [[ -n "$currentpkg" ]]; do
    finalfiles="$finalfiles /var/cache/pacman/pkg/$(cut -d'.' -f1 <<<"${currentpkg##*/}")*"
  done < "aurpackages"
  echo "Deleting files $finalfiles..."
  sudo rm -rf $finalfiles
  # sudo rm -rf ./customrepo
  echo "Saving iso file..."
  sudo cp -f ./workingdir/out/*.iso ./output.iso
  echo "Removing archiso directory..."
  # sudo rm -rf workingdir
}
appendaurpkgs() {
  printf $'\n' | sudo tee -a workingdir/packages.x86_64
  cat aurpackages | sudo tee -a workingdir/packages.x86_64
}
setupsyslinux() {
  sudo sed -i 's/APPEND archisobasedir=%INSTALL_DIR% archisolabel=%ARCHISO_LABEL%/APPEND archisobasedir=%INSTALL_DIR% archisolabel=%ARCHISO_LABEL% cow_spacesize=1G/g' workingdir/syslinux/syslinux-linux.cfg
}
createdir
copyairootfs
copypackages
createlsbrelease
compileaurpkgs
appendaurpkgs
setuprepo
setupsyslinux
buildtheiso
cleanup
