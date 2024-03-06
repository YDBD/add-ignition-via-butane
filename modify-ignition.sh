## Generate ignition from butane file

podman run --rm --tty --interactive \
    --volume ./config:/builder \
    --workdir /builder \
    quay.io/coreos/coreos-installer:main \
    iso ignition show /builder/rhcos-live.x86_64.iso
