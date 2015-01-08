# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  
#  config.vm.define :web1 do |duggy|
#    duggy.vm.box = "CentOS_6.6_x86_64"
#    duggy.vm.network "private_network", ip: "192.168.33.10"
#  end

#  config.vm.define :db do |duggy|
#    duggy.vm.box = "CentOS_6.6_x86_64"
#    duggy.vm.network "private_network", ip: "192.168.33.12"
#  end

  config.vm.define :monitor do |duggy|
    duggy.vm.box = "CentOS-6.x"
    duggy.vm.network "private_network", ip: "192.168.33.14"

    duggy.vm.provision :ansible do |ansible|
      ansible.playbook = "playbook.yml"
#      ansible.limit = 'all'
#      ansible.verbose = 'vvvv'
    end
  end
end