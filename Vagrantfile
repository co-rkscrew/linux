# -*- mode: ruby -*-
# vi: set ft=ruby :

$provision_script = <<SCRIPT
  # configure apt proxy (add proxies in detect-http-proxy file)
  cp /vagrant/provision/etc/apt/detect-http-proxy /etc/apt/detect-http-proxy
  cp /vagrant/provision/etc/apt/apt.conf.d/30detectproxy /etc/apt/apt.conf.d/30detectproxy
  chmod +x /etc/apt/detect-http-proxy
  
  # install packages
  apt-get update
  apt-get install -y simple-cdd qemu syslinux rsync \
        devscripts debhelper lintian dh-make vim gdebi

  # provision
  rsync -av /vagrant/provision/ /
  chmod +x /vagrant/*.sh

  # rsync may screw perms
  chmod +x /etc/apt/detect-http-proxy
SCRIPT

Vagrant.configure(2) do |config|
  config.vm.box = "chef/debian-7.8"
  
  config.vm.network "private_network", ip: "192.168.33.10"

  config.vm.provision "shell", inline: $provision_script
end
