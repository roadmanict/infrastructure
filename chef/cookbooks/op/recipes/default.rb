package 'postfix'
package 'nginx'
package 'python3'

# --- Set host name ---
# Note how this is plain Ruby code, so we can define variables to
# DRY up our code:
hostname = 'roadmanict.nl'

cookbook_file '/etc/postfix/main.cf'
cookbook_file '/etc/aliases'

execute 'newaliases' do
  command '/usr/bin/newaliases'
end

service 'postfix' do
  action :restart
end
