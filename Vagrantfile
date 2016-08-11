# -*- mode: ruby -*-
# vi: set ft=ruby :

# NAME: Vagrantfile
# AUTHOR: Joaquin Menchaca
# CREATED: 2015-11-23
#
# PURPOSE: Configuration Script evalued by Vagrant.  Does the following:
#  * Configures three systems: chefserver, work, node
#  * Configures private network with static IP addresses
#  * provisions systems using shell scripts
# DEPENDENCIES:
#  * Vagrant 1.7.4+, VirtualBox 4.3.x or VirtualBox 5.x
#  * Global Configuration - default.hosts
# NOTES:
#  * VirtualBox systems will need to have GuestEditions installed so that
#    `/vagrant` will be mounted in the guest operating system

require 'yaml'

VMBOX            = ENV['VAGRANT_VMBOX'] || 'trusty'  # defalt to ubuntu trusty
TIME             = Time.now.strftime("%Y%m%d%H%M%S") # label system in vbox
CONFIGFILE_HOSTS = "./config/#{VMBOX}.hosts"         # choose appropriate hosts
VBOXEN_FILE      = "./config/vboxen.yml"             # list of vm.boxes on atlas
PRIMARY_SYSTEM   = "workstation" # designate default primary system

@vboxen = YAML.load(File.read(VBOXEN_FILE))

@hosts = Hash.new  # create hash to configure systems
# Read Default Hosts File:  'ipaddress hostname'
File.readlines(CONFIGFILE_HOSTS).map(&:chomp).each do |line|
  ipaddr, hostname = line.split(/\s+/)
  @hosts[hostname] = ipaddr
end

Vagrant.configure("2") do |config|
  @hosts.each do |hostname, ipaddr|
    default = if hostname == PRIMARY_SYSTEM then true else false end
    config.vm.define hostname, primary: default  do |host|
      host.vm.box = "#{@vboxen[VMBOX]}"
      host.vm.hostname = "#{hostname}"
      host.vm.network "private_network", ip: ipaddr

      # Virtualbox Provider Specific Configuration
      case hostname
      when /chefserver/
          host.vm.provider "virtualbox" do |vbox|
            vbox.memory = 4096
            vbox.cpus = 2
            vbox.name = "ubuntu_trusty_#{hostname}_#{TIME}"
          end
      else
          host.vm.provider("virtualbox") { |vbox| vbox.name = "ubuntu_trusty_#{hostname}_#{TIME}" }
      end

      # Provision Systems with Shell Scripts
      #host.vm.provision "shell", path: "scripts/#{hostname}.sh"
    end
  end
end
