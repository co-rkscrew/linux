# -*- mode: ruby -*-
# vi: set ft=ruby :

$provision_script = <<SCRIPT
  apt-get update
  apt-get install -y simple-cdd syslinux
SCRIPT

Vagrant.configure(2) do |config|
  config.vm.box = "chef/debian-7.8"
  config.vm.provision "shell", inline: $provision_script
end
