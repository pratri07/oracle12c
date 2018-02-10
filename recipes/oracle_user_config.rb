group 'dba' do
  gid node[:oracle][:user][:gid]
end

user 'oracle' do
  uid node[:oracle][:user][:uid]
  gid node[:oracle][:user][:gid]
  shell node[:oracle][:user][:shell]
  comment 'Oracle admin user'
  manage_home true
  password 'Linux123#'
end

yum_package File.basename(node[:oracle][:user][:shell])

#template "/home/oracle/.profile" do
#  action :create_if_missing
#  source 'ora_profile.erb'
#  owner 'oracle'
#  group 'dba'
#end

template "/home/oracle/.bash_profile" do
  source 'ora_profile.erb'
  owner 'oracle'
  group 'dba'
end

template "/etc/oratab" do
  source 'oratab.erb'
end

template "/etc/init.d/dbora" do
  source 'dbora.erb'
  mode '0750'
end

execute "Add chkconfig" do
  command "chkconfig --add dbora"
end

cookbook_file '/etc/security/limits.d/oracle.conf' do
  mode '0644'
  source 'ora_limits'
end

#execute "swap1" do
#  command "dd if=/dev/zero of=/var/myswap bs=1M count=600"
#end

#execute "swap2" do
#  command "mkswap /var/myswap"
#end

#execute "swap3" do
#  command "swapon /var/myswap"
#end

script 'create swapfile' do
  interpreter 'bash'
  not_if { File.exists?('/var/swapfile') }
  code <<-eof
    dd if=/dev/zero of=/var/swapfile bs=1M count=600 &&
    chmod 600 /var/swapfile &&
    mkswap /var/swapfile
  eof
end

mount '/dev/null' do  # swap file entry for fstab
  action :enable  # cannot mount; only add to fstab
  device '/var/swapfile'
  fstype 'swap'
end

script 'activate swap' do
  interpreter 'bash'
  code 'swapon -a'
end
