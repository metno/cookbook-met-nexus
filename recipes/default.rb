#
# Cookbook Name:: met-nexus
# Recipe:: default
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'apt'
include_recipe 'java'
include_recipe 'simple-nexus::default'
include_recipe 'met-server::it-geo-tf'
include_recipe 'met-server::secrets'

# Dropping reverse proxy in the first iteration. 
# Want a DNS entry
# We also need to updatete the base url in the nexus config.
# include_recipe 'met-nexus::nginx'


# This directory is created by by simple-nexus, but the template directive
# below checks if the directory exist at "compile time". The don't exist yet, 
# So create the directories already. 
%w[ /var/lib/nexus /var/lib/nexus/conf ].each do |path|
  directory path do
    owner node['nexus']['user']
    group node['nexus']['group']
    mode '0755'
  end
end

firewall_rule "http" do
    action :allow
    protocol :tcp
    port node['nexus']['conf']['application-port'].to_i
end

# The default users "admin", "deployment", 
# must exist, even if LDAP is enabled.
# Lets say you have LDAP user in in the deployment role.
# Nexus will then use the deployment user on the behalf of
# the LDAP user.
nexus_default_users = chef_vault_item('nexus', 'default_users')
template "#{node['nexus']['conf']['nexus-work']}/conf/security.xml" do
    source 'nexus/security.xml'
    owner node['nexus']['user']
    group node['nexus']['group']
    mode 0600
    sensitive true
    variables :default_users => nexus_default_users['users']
    notifies :restart, "service[nexus]"
end


# TODO:
# Add a task to periodically remove old snapshots
# Or just do it in the web interface for starters.
