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
copyskel() {
  sudo mkdir ./workingdir/airootfs/etc/skel
  sudo cp -r ./skeldata/* ./workingdir/airootfs/etc/skel/
  sudo ln -s /usr/lib/systemd/system/lightdm.service ./workingdir/airootfs/etc/systemd/system/display-manager.service
  sudo sed -i "s/multi-user.target/graphical.target/g" ./workingdir/airootfs/root/customize_airootfs.sh
}
createlsbrelease() {
  echo "lsb-release" | sudo tee --append ./workingdir/packages.x86_64 > /dev/null
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
    for d in */ ; do
      cd "$d"
    done
    # makepkg -s
    cp *.pkg.ta* ../../x86_64
    cd $buildingpath
    for d in */ ; do
      rm -rf "$d"
    done
    cd $repopath
  done < "aurpackages"
  rm -rf customrepo/custompkgs
  unset repopath buildingpath
  cat aurpackages | sudo tee workingdir/packages.x86_64
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
  cp ./workingdir/out/*.iso ./output.iso
  echo "Removing archiso directory..."
  # sudo rm -rf workingdir
}
createdir
copypackages
copyskel
createlsbrelease
compileaurpkgs
setuprepo
buildtheiso
cleanup
