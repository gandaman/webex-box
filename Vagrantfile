# (C) 2014-2016 Gunnar Andersson
# License: MPLv2

# -*- mode: ruby -*-
# vim: set ft=ruby sw=4 ts=4 tw=0 et:

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

# Apparently this needs to be specified if Vagrant has alternative options
# (try other Vagrant providers at your own risk)
ENV['VAGRANT_DEFAULT_PROVIDER'] = 'virtualbox'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

   # Set defaults, or as defined by environment variables

   hostname = ENV['VMNAME']
   hostname = 'webex-linux-box' if hostname == nil

   box = ENV['BOX']
   box = "maier/alpine-3.6-x86_64" if box == nil

#   box_url = ENV['BOX_URL']
#   box_url = "http://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-i386-vagrant-disk1.box" if box_url == nil

   config.vm.box = box
#   NOT supported on Alpine config.vm.hostname = hostname
#   config.vm.box_url = box_url

   # Set a unique tag
   vmname = hostname + "-" + Time.now.strftime("%Y%m%d%H%M")
   config.vm.provider :virtualbox do |vb|
      vb.gui = false

      # maier/alpine recommended settings
      vb.customize [
         'modifyvm', :id,
         '--natdnshostresolver1', 'on',
         '--nic1', 'nat',
         '--cableconnected1', 'on'
      ]

      vb.customize [ "modifyvm", :id, "--name", vmname ]
      vb.customize [ "modifyvm", :id, "--memory", "2048" ]
      vb.customize [ "modifyvm", :id, "--vram", "128" ]
      vb.customize [ "modifyvm", :id, "--clipboard" , "bidirectional" ]
      vb.customize [ "modifyvm", :id, "--cpus", 2 ]

   end

   #   config.vm.synced_folder ".", "/vagrant", type: "nfs"
config.vm.synced_folder ".", "/vagrant", disabled: true

   config.vm.provision :shell, inline:
      'echo "***************************************************************"
       echo "Starting provisioning. "
       echo "***************************************************************"

       apk add --update git
       cd /home/vagrant
       git clone --branch alpinelinux https://github.com/gandaman/webex-box
       cd webex-box

      [ -f ./script.sh ] && sh -x ./script.sh
      '
      config.vm.provision :shell, inline:
      ' sudo chown -R vagrant:vagrant /home/vagrant
      echo #{vmname} >/vagrant/VMNAME
      '
end
