# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "ubuntu/xenial64"


  config.vm.define "vm1" do |vm1|
     vm1.vm.network :private_network, ip: "192.168.56.101"
     vm1.vm.hostname="vm1"
     vm1.vm.provision "shell", inline: <<-SHELL
	     echo "192.168.56.101 salt" >> /etc/hosts
 	     apt-get update
	     apt-get install wget
	     wget -O - https://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add -
	     echo "deb http://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest xenial main" >> /etc/apt/sources.list.d/saltstack.list
	     apt-get update
	     apt-get install salt-master salt-minion python-pygit2 python-git --yes
             echo "open_mode: True" >> /etc/salt/master #we don't care about security
             echo "auto_accept: True" >> /etc/salt/master #we don't care about security
             echo "file_roots:\n  base:\n    - /srv/salt\n    - /srv/formulas/hostsfile-formula\n    - /srv/formulas/openssh-formula\n    - /srv/formulas/docker-formula\n" >> /etc/salt/master
             mkdir -p /srv/formulas
             cd /srv/formulas
             git clone https://github.com/saltstack-formulas/hostsfile-formula.git
	     git clone https://github.com/saltstack-formulas/openssh-formula.git
             git clone https://github.com/saltstack-formulas/docker-formula.git

             mkdir /srv/salt/
             echo 'base:\n  "*":\n    - hostsfile\n    - openssh\n    - docker' > /srv/salt/top.sls


	     echo "rejected_retry: True" >> /etc/salt/minion
             echo "mine_functions:\n  network.interfaces: []\n  network.ip_addrs:\n    - enp0s8\nmine_interval: 2"  >> /etc/salt/minion

             service salt-master restart

	     service salt-minion restart
      SHELL

  end
  

  (2..4).each do |i|
	  config.vm.define "vm%d" % [ i ] do |node|

	     node.vm.hostname="vm%d" % [i]
	     node.vm.network :private_network, ip: "192.168.56.%d" % [100+i]
	     node.vm.provision "shell", inline: <<-SHELL
		    echo "192.168.56.101 salt" >> /etc/hosts
	
	             apt-get update
	             apt-get install wget
	             wget -O - https://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add -
	             echo "deb http://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest xenial main" >> /etc/apt/sources.list.d/saltstack.list
	             apt-get update
	             apt-get install salt-minion --yes
		     echo "rejected_retry: True" >> /etc/salt/minion
                     echo "mine_functions:\n  network.interfaces: []\n  network.ip_addrs:\n    - eth1\nmine_interval: 2"  >> /etc/salt/minion
                     service salt-minion restart

             
	      SHELL

	  end
  end




  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
end
