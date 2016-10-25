hostname = 'acc.roadmanict.nl'

# ufw
package 'ufw'

execute 'ufw allow ssh' do
  command '/usr/sbin/ufw allow 22/tcp'
end

service 'ufw' do
    action [:enable, :start]
end

# Postfix
package 'postfix'

cookbook_file '/etc/postfix/main.cf'
cookbook_file '/etc/aliases'

execute 'newaliases' do
  command '/usr/bin/newaliases'
end

service 'postfix' do
  action :restart
end

# SSH
cookbook_file '/etc/ssh/sshd_config'

service 'ssh' do
  action :restart
end

# Backports
cookbook_file '/etc/apt/sources.list'
execute "update apt" do
  command "apt-get update"
end

# Letsencrypt
execute "install certbot" do
  command "apt-get -t jessie-backports install certbot -y"
end

# nginx
package 'nginx'

execute 'ufw allow http' do
  command '/usr/sbin/ufw allow http'
  command '/usr/sbin/ufw allow https'
end

# Monit
package 'monit'

cookbook_file '/etc/monit/monitrc'

service 'monit' do
  action [:enable, :restart]
end

service 'nginx' do
  action [:stop]
end

execute "monit certbot" do
    command 'certbot certonly -n --agree-tos --keep --standalone -d monit.roadmanict.nl --email geert@gweggemans.nl'
end

cookbook_file '/etc/nginx/sites-enabled/monit.conf'

service 'nginx' do
  action [:enable, :restart]
end