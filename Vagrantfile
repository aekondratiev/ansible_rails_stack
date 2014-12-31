# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.ssh.insert_key = false
  
  config.vm.define :web1 do |web1|
    web1.vm.box = "CentOS_6.6_x86_64"
  # web1.ssh.private_key_path = "/Users/pilgrim/Dev/ansible/.ssh/id_rsa"
  # web1.vm.network "forwarded_port", guest: 80, host: 8080
    web1.vm.network "private_network", ip: "192.168.33.10"
  end

  config.vm.define :db do |db|
    db.vm.box = "CentOS_6.6_x86_64"
  # db.vm.network "forwarded_port", guest: 80, host: 8080
    db.vm.network "private_network", ip: "192.168.33.12"
  end

  config.vm.define :monitor do |mon|
    mon.vm.box = "CentOS_6.6_x86_64"
  # mon.vm.network "forwarded_port", guest: 80, host: 8080
    mon.vm.network "private_network", ip: "192.168.33.14"
  end
end