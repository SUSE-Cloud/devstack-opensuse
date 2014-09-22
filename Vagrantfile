# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define "devstack1" do |dev|
    dev.vm.box = "toabctl/devstack-openSUSE13.1"
    dev.vm.hostname = "devstack1.local"
    config.vm.network :forwarded_port, guest: 80, host: 8080

    ### Provider specific options ###
    dev.vm.provider :libvirt do |libvirt|
      libvirt.memory = 6144
      libvirt.nested = true
      libvirt.cpus = 2
    end

    config.vm.provision "shell", path: "vagrant-devstack-setup.sh"
  end
end
