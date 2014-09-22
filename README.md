# devstack-opensuse-vagrant

Vagrant box with openSUSE for devstack


## Building the openSUSE 13.1 box with kiwi

Create the box with `kiwi` (use a recent version from https://build.opensuse.org/project/show/Virtualization:Appliances)
The box has already some needed packages installed to speedup the initial `devstack` setup.

```
sudo kiwi --build openSUSE-13.1-kiwi/ -d /tmp/opensuse-13.1-box
```

Add the box to vagrant with:

```
vagrant box add toabctl/devstack-openSUSE13.1 /tmp/opensuse-13.1-box/VagrantBox-openSUSE-13.1.x86_64-0.1.0.libvirt.box
```
