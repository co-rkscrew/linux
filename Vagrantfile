# -*- mode: ruby -*-
# vi: set ft=ruby :

$provision_script = <<SCRIPT
  # configure apt proxy (add proxies in detect-http-proxy file)
  cp /vagrant/provision/etc/apt/detect-http-proxy /etc/apt/detect-http-proxy
  cp /vagrant/provision/etc/apt/apt.conf.d/30detectproxy /etc/apt/apt.conf.d/30detectproxy
  chmod +x /etc/apt/detect-http-proxy
  
  # install packages
  cp /vagrant/provision/etc/apt/sources.list /etc/apt/sources.list
  apt-get update
  apt-get install -y simple-cdd qemu syslinux-utils rsync \
        devscripts debhelper lintian dh-make vim gdebi
  
  # provision
  rsync -av /vagrant/provision/ /
  chmod +x /vagrant/*.sh

  # dirty fix for debian-cd (support stretch)
  ln -s /usr/share/debian-cd/tasks/wheezy/ /usr/share/debian-cd/tasks/stretch
  ln -s /usr/share/debian-cd/data/jessie/ /usr/share/debian-cd/data/stretch
  ln -s /usr/share/debian-cd/tools/boot/jessie/ /usr/share/debian-cd/tools/boot/stretch

SCRIPT

Vagrant.configure(2) do |config|
  # debian 7 wheezy
  #config.vm.box = "chef/debian-7.8"
  # debian 9 stretch
  config.vm.box = "sharlak/debian_stretch_64"
  
  config.vm.network "private_network", ip: "192.168.33.10"

  config.vm.provision "shell", inline: $provision_script
end
