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
    vb.cpus = VB_CPUS    # Default is 1
    vb.memory = VB_MEM   # Default is 512MB
  end

  config.vm.define :web1 do |machine|
		machine.vm.hostname = 'web1'		
    machine.vm.network "private_network", ip: PRIVATE_WEB_IP
  end

  config.vm.define :db do |machine|
    machine.vm.hostname = 'db'
    machine.vm.network "private_network", ip: PRIVATE_DB_IP
  end

  config.vm.define :monitor do |machine|
		machine.vm.hostname = 'monitor'
    machine.vm.network "private_network", ip: PRIVATE_MONITOR_IP

    machine.vm.provision :ansible do |ansible|
      ansible.playbook = "site.yml"
      ansible.limit = 'all'
#      ansible.verbose = 'v'
#       ansible.start_at_task = ""
      ansible.sudo = true
			ansible.groups = {
        "group1" => ["monitor"],
        "group2" => ["db"],
        "group3" => ["web1"]
      }
    end
  end
end