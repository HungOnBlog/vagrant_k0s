# -*- mode: ruby -*-
# vi: set ft=ruby :

ENV['VAGRANT_NO_PARALLEL'] = 'yes'

Vagrant.configure(2) do |config|

  config.vm.provision "shell", path: "bootstrap.sh"

  config.vm.define "xmaster" do |node|

    node.vm.box               = "generic/ubuntu2004"
    node.vm.box_check_update  = false
    node.vm.box_version       = "3.3.0"
    node.vm.hostname          = "xmaster.example.com"

    node.vm.network "private_network", ip: "192.168.56.10"

    node.vm.provider :virtualbox do |v|
      v.name    = "xmaster"
      v.memory  = 1024
      v.cpus    = 1
    end

    node.vm.provider :libvirt do |v|
      v.nested  = true
      v.memory  = 1024
      v.cpus    = 1
    end

  end

  NodeCount = 2

  (1..NodeCount).each do |i|

    config.vm.define "xworker#{i}" do |node|

      node.vm.box               = "generic/ubuntu2004"
      node.vm.box_check_update  = false
      node.vm.box_version       = "3.3.0"
      node.vm.hostname          = "xworker#{i}.example.com"

      node.vm.network "private_network", ip: "192.168.56.1#{i}"

      node.vm.provider :virtualbox do |v|
        v.name    = "xworker#{i}"
        v.memory  = 1024
        v.cpus    = 1
      end

      node.vm.provider :libvirt do |v|
        v.nested  = true
        v.memory  = 1024
        v.cpus    = 1
      end

    end

  end

end
