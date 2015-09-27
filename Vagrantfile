# options
# -------

# sets if verbose mode is enabled for Ansible
ansible_verbose = true

# when true, provisioning the VM will only install missing app gems via
# Bundler
only_bundle_on_provision = true

# -------

Vagrant.configure(2) do |config|
  app_dir = '/app'
  app_name = 'saso'

  config.vm.box = 'ubuntu/vivid64'
  config.vm.hostname = app_name

  config.vm.synced_folder '.', app_dir
  config.vm.network :private_network, ip: '10.0.5.7'

  config.vm.provider :virtualbox do |v|
    v.name = "#{app_name}_web_vagrant"
    v.memory = 1024
  end

  extra_vars = {
    app: {
      dir: app_dir,
      name: app_name
    },
    vm: {
      dir: '/home/vagrant'
    },
    ssh_user: 'vagrant'
  }

  config.vm.provision :ansible do |ansible|
    ansible.extra_vars = extra_vars

    if ansible_verbose
      ansible.verbose = 'vv'
    end

    if only_bundle_on_provision
      ansible.tags = 'bundle'
    end

    ansible.skip_tags = 'boot'
    ansible.playbook = 'playbook.yml'
  end

  config.vm.provision :ansible, run: 'always' do |ansible|
    ansible.extra_vars = extra_vars

    if ansible_verbose
      ansible.verbose = 'vv'
    end

    ansible.tags = 'boot'
    ansible.playbook = 'playbook.yml'
  end
end
