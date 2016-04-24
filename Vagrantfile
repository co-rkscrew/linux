# -*- mode: ruby -*-
# vi: set ft=ruby :

$provision_script = <<SCRIPT
  # install packages
  apt-get update
  apt-get install -y simple-cdd qemu syslinux-utils rsync \
        devscripts debhelper lintian dh-make vim gdebi build-essential

  # provision
  cp /vagrant/provision/bash.bashrc /etc/bash.bashrc

  # dirty fix for debian-cd (support stretch)
  ln -s /usr/share/debian-cd/tasks/wheezy/ /usr/share/debian-cd/tasks/stretch
  ln -s /usr/share/debian-cd/data/jessie/ /usr/share/debian-cd/data/stretch
  ln -s /usr/share/debian-cd/tools/boot/jessie/ /usr/share/debian-cd/tools/boot/stretch
SCRIPT

Vagrant.configure(2) do |config|
  config.vm.box = "fujimakishouten/debian-stretch64"

  config.vm.provision "shell", inline: $provision_script

  config.vm.provider "virtualbox" do |v|
    v.customize [
      "modifyvm", :id,
      "--ioapic", "on",
      "--cpus", "4",
      "--memory", "4096"
    ]
  end
end
