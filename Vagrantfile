# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'socket'
require 'ipaddr'

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"


Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.hostname = "postgis-vagrant"

  # To confirm that ssh fowarding is working, run the following from inside the
  # guest machine:
  #
  #   ssh -T git@github.com
  #
  # You should see something like "Hi <your name here>! You've successfully
  # authenticated, but GitHub does not provide shell access."
  #
  # You may need to run `ssh-add` on your host machine to add your private key
  # identities to the authentication agent.
  config.ssh.forward_agent = true
  
  # For remote access to the PostgreSQL server, 
  # forward port 6543 on the host to 5432 on the guest
  config.vm.network :forwarded_port, guest: 5432, host: 6543

  # VirtualBox specific configurations
  config.vm.provider :virtualbox do |vb|

    # How much memory to use?
    vb.customize ["modifyvm", :id, "--memory", 2048]

    # How many CPUs to use?
    vb.customize ["modifyvm", :id, "--cpus", 1]

    # Fast I/O?
    # vb.customize ["modifyvm", :id, "--ioapic", "on"]

    # Use the VirtualBox GUI for graphic desktop?
    vb.gui = false
    
  end

  # OSX specific configuration
  if RUBY_PLATFORM.include? "darwin"
    # Customize the private network's IP. 
    # config.vm.network "private_network", ip: "192.168.50.4"

    # Use NFS for the synced folder?
    # config.vm.synced_folder ".", "/vagrant", nfs: true
  end

  # Windows specific configuration
  if RUBY_PLATFORM.include? "win32"
    config.vm.synced_folder ".", "/vagrant", type: "smb"
  end


  ##################################################################################
  # Centos
  #

  config.vm.box = "chef/centos-6.5" 
  config.vm.box_url = "https://vagrantcloud.com/chef/boxes/centos-6.5/versions/1.0.0/providers/virtualbox.box"

  preCmd = ""
  updateCmd = "yum update -y"

  repoCmd = "rpm -Uv"
  repoList = [
    "http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm",
    "http://yum.postgresql.org/9.2/redhat/rhel-6-x86_64/pgdg-centos92-9.2-6.noarch.rpm"
  ]

  packageCmd = "yum install -y"
  packageList = [
    "git",
    "subversion",
    "pkgconfig",
    "cmake",
    "perl",
    "autoconf",
    "screen",
    "libtool",
    "gtk2-devel",
    "geos-devel",
    "gdal-devel",
    "proj-devel",
    "proj-nad",
    "libxml2-devel",
    "json-c-devel",
    "CUnit-devel",
    "libxslt-devel",
    "docbook-style-xsl",
    "ImageMagick",
    "glibc",
    "gcc",
    "readline",
    "readline-devel",
    "zlib",
    "zlib-devel",
    "libgssapi",
    "libgssapi-devel",
    "openssl-devel",
    "pam-devel",
    "openldap-devel",
    "python-devel",
    "gcc-c++",
    "libxml2-devel",
    "compat-libf2c-34",
    "compat-gcc-34",
    "freeglut",
    "libXp-devel",
    "libXtst-devel",
    "libXtst",
    "libXext",
    "libXmu-devel",
    "libXmu",
    "freetype",
    "gedit",
    "fontconfig",
    "xorg-x11-server",
    "xorg-x11-server-common",
    "xorg-x11-server-utils",
    "xorg-x11-server-devel",
    "cairo",
    "postgresql92",
    "postgresql92-devel",
    "postgresql92-server",
    "postgresql92-contrib",
    "postgresql92-lib",
    "postgis2_92"
  ];      
    
  # Run the initialization only the first time...
  if Dir.glob("#{File.dirname(__FILE__)}/.vagrant/machines/default/*/id").empty?

	  inlineScript = ""

    if preCmd != ""
      inlineScript << preCmd << " ; "
    end

    # Install all the extra repositories
	  if repoList.length > 0
		  repoList.each { |repo| inlineScript << repoCmd << " " << repo << " ; " }
	  end

    # Update the base software (this takes time!)
    # inlineScript << updateCmd << " ; "

	  # install packages we need we need
	  inlineScript << packageCmd << " " << packageList.join(" ") << " ; "
	  config.vm.provision :shell, :inline => inlineScript

    scripts = [
       "startup.sh"
    ];
    
    scripts.each { |script| config.vm.provision :shell, :path => "scripts/vagrant/" << script }
  end
  

end
