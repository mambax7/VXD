Vagrant.configure("2") do |config|

  # Load config JSON
  vxd_config_path = File.expand_path(File.dirname(__FILE__)) + "/config.json"
  vxd_config = JSON.parse(File.read(vxd_config_path))

  # Base box
#  config.vm.box = "precise32"
#  config.vm.box_url = "http://files.vagrantup.com/precise32.box"
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  # Networking
  config.vm.network :private_network, ip: vxd_config["ip"]

  # Customize provider
  config.vm.provider :virtualbox do |vb|
    # RAM
    vb.customize ["modifyvm", :id, "--memory", vxd_config["memory"]]

    # Synced Folder
    config.vm.synced_folder vxd_config["synced_folder"]["host_path"],
      vxd_config["synced_folder"]["guest_path"],
      :nfs => vxd_config["synced_folder"]["use_nfs"]
  end

  # Customize provisioner
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = [
      "cookbooks/site",
      "cookbooks/core",
      "cookbooks/custom"
    ]
    chef.roles_path = "roles"

    # Prepare chef JSON
    chef.json = vxd_config

    # Add VDD role
    chef.add_role "vxd"

    # Add custom roles
    vxd_config["custom_roles"].each do |role|
      chef.add_role role
    end
  end

end
