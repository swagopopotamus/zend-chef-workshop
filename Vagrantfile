# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

# Determine a good memory size for your use case
VM_RAM_SIZE_MB = "256"
VM_DISPLAY_NAME = "workshop-example-1"
VM_PRIVATE_NETWORK_IP = "10.230.230.10"
VM_BOX_NAME = "pp64-chef11.6"
VM_BOX_URL = "https://oss-binaries.phusionpassenger.com/vagrant/boxes/ubuntu-12.04.3-amd64-vbox.box"

# Relative to Vagrantfile; most of these are default values
# See http://docs.vagrantup.com/v2/provisioning/chef_solo.html
# and http://docs.vagrantup.com/v2/provisioning/chef_common.html
CHEF_COOKBOOKS_PATH = "./cookbooks"
#CHEF_DATABAGS_PATH = "data_bags"
#CHEF_ENCRYPTED_DATABAG_KEY_PATH = ""
#CHEF_ENV_PATH = ""
#CHEF_ENV = ""
#CHEF_NFS = false
#CHEF_RECIPE_URL = "http://archive/of/cookbooks/to/download"
#CHEF_ROLES_PATH = ""

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
# cachier and omnibus plugins should come first!
  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.auto_detect = true
  end
  
  # Hack to cache Omnibus locallly
  #if (defined? VagrantPlugins::Cachier && defined? VagrantPlugins::Omnibus)
  #  ENV['OMNIBUS_INSTALL_URL']="https://gist.github.com/hectcastro/6443633/raw/install.sh"
  #  puts "setting custom OMNIBUS_INSTALL_URL for vagrant-cachier: #{ENV['OMNIBUS_INSTALL_URL']}"
  #end


  # if Vagrant.has_plugin?("vagrant-omnibus")
  #  always get current: config.omnibus.chef_version = :latest
  #  determine specific version: config.omnibus.chef_version = "11.6.0"
  # end

  # Vagrant box to build upon
  config.vm.box = VM_BOX_NAME
  # The url from where 'config.vm.box' box will be fetched if it doesn't
  # already exist on the host.
  config.vm.box_url = VM_BOX_URL

  config.vm.provider :virtualbox do |v|
    v.customize ["modifyvm", :id, "--memory", VM_RAM_SIZE_MB]
    v.customize ["modifyvm", :id, "--name", VM_DISPLAY_NAME]
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  end

  # Create a private network using a specific IP
  config.vm.network :private_network, ip: VM_PRIVATE_NETWORK_IP

  # Enable provisioning with chef solo, specifying a cookbooks path, roles
  # path, and data_bags path (all relative to this Vagrantfile), and adding
  # some recipes and/or roles.
  #
  config.vm.provision :chef_solo do |chef|
    chef.provisioning_path = "/tmp/vagrant-chef-solo"
    chef.file_cache_path = chef.provisioning_path
    chef.cookbooks_path = CHEF_COOKBOOKS_PATH

    chef.add_recipe "zendserver::single"
    # JSON attributes, to override defaults or supply required values:
    chef.json = {
      :zendserver => {
        :version => '6.3',
        :phpversion => '5.5',
        :adminpassword => 'admin',
        :apikeyname => 'single',
        :apikeysecret => 'cj0vSBjESqmp95Q08L55zGGXzhNdXx2xdwslqTrPz7W2L3CONLB52K3QxIkS5qW0',
        :adminemail => 'clark.e@zend.com',
        :ordernumber => 'CLARK',
        :licensekey => 'TP128340C01G210662FCF086A7CBA849'
      }
    }
  end
end
