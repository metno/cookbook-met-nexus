#
# Cookbook Name:: met-nexsus
# Recipe:: nginx
#
# Copyright (C) 2015 MET Norway
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'nginx'
include_recipe 'met-server::secrets'


template '/etc/nginx/sites-available/met-nexus.conf' do
    source 'nginx.conf.erb'
    owner 'root'
    group 'root'
    mode '0644'
    notifies :restart, 'service[nginx]'
end

link '/etc/nginx/sites-enabled/met-nexus.conf' do
    to '/etc/nginx/sites-available/met-nexus.conf'
    notifies :restart, 'service[nginx]'
end


met_server_certificate "nginx ssl certificate" do
    name node['met-nexus']['nginx']['ssl_name']
    notifies :restart, "service[nginx]"
end

firewall_rule "http" do
    action :allow
    protocol :tcp
    port 80
end

firewall_rule "https" do
    action :allow
    protocol :tcp
    port 443
end
