# Setup k8s (Kubernetes) cluster in local environment using Vagrant and k0s

![Vagrant and k0s](./k8s_k0s_vagrant.png)

## Setup Vagrant
### Install virtualbox
Download page: [Virtualbox](https://www.virtualbox.org/wiki/Downloads)

#### For Ubuntu
```bash
sudo apt install virtualbox
```
### Install Vagrant
Vagrant download page: [Vagrant](https://developer.hashicorp.com/vagrant/downloads)

#### For Ubuntu
Current version **Vagrant 2.3.2**
```bash
wget https://releases.hashicorp.com/vagrant/2.3.2/vagrant-2.3.2-1.x86_64.rpm

sudo rpm -i vagrant-2.3.2-1.x86_64.rpm
```
### Vagrantfile
Create file name Vagrantfile in working directory

The content of this file is:
- Create a vm named master that:
    - Use ubuntu 20.04 image
    - Has 1 CPU and 1GB RAM
    - Has a private network with IP 192.168.56.100
- Create 2 vm:
    - Named worker1 and worker2
    - Has 1 CPU and 1GB RAM
    - Has a private network with IP
        - 192.168.56.101
        - 192.168.56.102
```
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

    node.vm.network "private_network", ip: "192.168.56.100"

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

      node.vm.network "private_network", ip: "192.168.56.10#{i}"

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

```

### Bootstrap
The bootstrap.sh file is used to run bootstrap commands on all nodes

It will set authentication with password for root user 
user: root
password: admin

```bash
#!/bin/bash

# Enable ssh password authentication
echo "Enable ssh password authentication"
sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/.*PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
systemctl reload sshd

# Set Root password
echo "Set root password"
echo -e "admin\nadmin" | passwd root >/dev/null 2>&1
```

### Create the vm
Run the following command to create the vm
```bash
vagrant up
```

## Setup k0s
### Install k0sctl
### k0sctl.yaml
### SSH
### Setup cluster