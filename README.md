# Add ssh key to RHCOS ISO via butane

Official documentation : https://coreos.github.io/butane/getting-started/

## Download RHCOS iso : 

https://mirror.openshift.com/pub/openshift-v4/dependencies/rhcos/

## Create the butane file

Modify the sample below to add your administrator public key, and rename the extension file as ".bu":

[Sample](/config/add-ssh-key.sample)

## Generate the ignition config file.
```bash
podman run -i --rm quay.io/coreos/butane:latest --pretty --strict < ./config/add-ssh-key.bu > ./config/added-ssh-key.ign
```

## Embed the ignition config file in the ISO.
```bash
podman run --rm --tty --interactive \
    --volume ./config:/builder \
    --workdir /builder \
    quay.io/coreos/coreos-installer:main \
    iso ignition embed -i ./added-ssh-key.ign ./rhcos-live.x86_64.iso
```

## Show if the ignition is added or removed
```bash
podman run --rm --tty --interactive \
    --volume ./config:/builder \
    --workdir /builder \
    quay.io/coreos/coreos-installer:main \
    iso ignition show /builder/rhcos-live.x86_64.iso
```

## Remove the ignition configuration file.
```bash
podman run --rm --tty --interactive \
    --volume ./config:/builder \
    --workdir /builder \
    quay.io/coreos/coreos-installer:main \
    iso ignition remove ./rhcos-live.x86_64.iso
```

## Execute coreos-installer.
```bash
podman run --rm --tty --interactive \
    --volume ./config:/builder \
    --workdir /builder \
    quay.io/coreos/coreos-installer:main
    ## put args here
```