# Arch USB Live builder

I am using this to build my USB live stick. You could try and build this, but I won't guarantee anything.

## Building

```sh
sudo docker build . -t archusb
docker run --rm --name archusb --privileged -it -v $(pwd)/out:/build/out --network=host archusb
```

The output .iso is in the folder `out/`
After building, if you want to put this to an USB run:

1. Copy the files from the .iso file to an empty drive formatted with FAT32.
2. Run `syslinux --directory /arch/boot/syslinux --install /dev/sdc1`
