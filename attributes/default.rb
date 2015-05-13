default['java']['install_flavor'] = 'openjdk'
default['java']['jdk_version'] = '7'

default['nginx']['default_site_enabled'] = false
default['nginx']['init_style'] = 'upstart'

default['met-nexus']['nginx']['domain'] = node['fqdn']
default['met-nexus']['nginx']['ssl_name'] = node['fqdn']
