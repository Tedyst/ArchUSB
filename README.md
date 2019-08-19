# Arch USB Live builder

I am using this to build my USB live stick. You could try and build this, but I won't guarantee anything.

## Building

```sh
sudo docker build . -t archusb
docker run --rm --name archusb --privileged -it -v $(pwd)/out:/build/out --network=host archusb
```