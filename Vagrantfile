Vagrant.configure(2) do |config|
  app_dir = '/app'
  app_name = 'saso'

  config.vm.box = 'ubuntu/trusty64'
  config.vm.hostname = app_name

  config.vm.synced_folder '.', app_dir
  config.vm.network :private_network, ip: '10.0.5.7'

  config.vm.provider :virtualbox do |v|
    v.name = "#{app_name}_web_vagrant"
    v.cpus = 4
    v.memory = 1024
  end

  config.vm.provision :ansible do |ansible|
    ansible.extra_vars = {
      app: {
        dir: app_dir,
        name: app_name
      },
      vm: {
        dir: '/home/vagrant'
      },
      ssh_user: 'vagrant'
    }

    if ENV['DEBUG']
      ansible.verbose = 'vv'
    end

    if ENV['BUNDLE']
      ansible.tags = 'bundle'
    end

    ansible.playbook = 'playbook.yml'
  end

  config.vm.post_up_message = 'Start the Rails server from any directory with `serve`'
end
