
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.provider :virtualbox do |vb|
    vb.memory = 2048
    vb.cpus = 2
  end

  config.vm.network "private_network", type: "dhcp"

  config.vm.network :forwarded_port, guest: 3000, host: 3001

  config.vm.synced_folder ".", "/vagrant", type: "nfs"

  config.ssh.forward_agent = true

  config.omnibus.chef_version = '12.10.24'

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = ["cookbooks"]

    chef.add_recipe "apt"
    chef.add_recipe "packages"
    chef.add_recipe "ruby_build"
    chef.add_recipe "ruby_rbenv::user"
    chef.add_recipe "memcached"
    chef.add_recipe "redisio"
    chef.add_recipe "redisio::enable"
    chef.add_recipe "postgresql"
    chef.add_recipe "postgresql::server"
    chef.add_recipe "resolver"
    chef.add_recipe "heroku-toolbelt"
    chef.add_recipe "nodejs"

    chef.json = {
      resolver: {
        nameservers: ["8.8.8.8", "8.8.4.4"]
      },
      "packages-cookbook" => ['libpq-dev'],
      rbenv: {
        user_installs: [{
          user: 'vagrant',
          rubies: ["2.5.0"],
          global: "2.5.0",
          gems: {
            "2.5.0" => [
              { name: "bundler" }
            ]
          }
        }]
      },
      postgresql: {
        version: '9.5',
        users: [
          { 
            username: 'vagrant', 
            superuser: true, 
            replication: false,
            createdb: true,
            createrole: true,
            inherit: true
          }
        ],
        config: {
          ssl: false
        },
        listen_addresses: "*",
        pg_hba: [
          { type: 'local', db: 'all', user: 'all', addr: nil, method: 'trust' },
          { type: 'host', db: 'all', user: 'all', addr: '0.0.0.0/0', method: 'trust' },
        ]
      }
    }
  end
end

`
if [ #{ARGV[0]} = 'up' ]; then
  ssh-add ~/.ssh/id_rsa
fi
`