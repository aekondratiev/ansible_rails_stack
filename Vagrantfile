# -*- mode: ruby -*-
# vi: set ft=ruby :

PRIVATE_WEB_IP="192.168.33.135"
PRIVATE_DB_IP="192.168.33.136"
PRIVATE_MONITOR_IP="192.168.33.137"
VB_MEM="1024"
VB_CPUS="4"

Vagrant.configure(2) do |config|
	config.vm.box = "mjp182/CentOS_7"

  config.ssh.insert_key = false

  config.vm.provider "virtualbox" do |vb|
    vb.cpus = VB_CPUS    # Default is "1"
    vb.memory = VB_MEM   # Default is "512"
  end

  config.vm.define :web1 do |web1|
		web1.vm.hostname = 'web1'
    web1.vm.network "forwarded_port", guest: 3000, host: 3000		
    web1.vm.network "private_network", ip: PRIVATE_WEB_IP
  end

  config.vm.define :db do |db|
    db.vm.hostname = 'db'
    db.vm.network "private_network", ip: PRIVATE_DB_IP
  end

  config.vm.define :monitor do |monitor|
		monitor.vm.hostname = 'monitor'
    monitor.vm.network "private_network", ip: PRIVATE_MONITOR_IP
  end
end