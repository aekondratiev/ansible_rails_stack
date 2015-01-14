# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
	config.vm.box = "mjp182/CentOS_6.6"
	
  config.ssh.insert_key = false

  config.vm.provider "virtualbox" do |vb|
    vb.cpus = "4"  
    vb.memory = "1024"
  end

  config.vm.define :web1 do |machine|
		machine.vm.hostname = 'web1'		
    machine.vm.network "private_network", ip: "192.168.33.135"
  end

  config.vm.define :db do |machine|
    machine.vm.hostname = 'db'
    machine.vm.network "private_network", ip: "192.168.33.136"
  end

  config.vm.define :monitor do |machine|
		machine.vm.hostname = 'monitor'
    machine.vm.network "private_network", ip: "192.168.33.137"

    machine.vm.provision :ansible do |ansible|
      ansible.playbook = "playbook.yml"
      ansible.limit = 'all'
			ansible.groups = {
        "group1" => ["monitor"],
        "group2" => ["db"],
        "group3" => ["web1"]
      }
    end
  end
end