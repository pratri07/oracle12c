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

template "/home/oracle/.kshrc" do
  action :create_if_missing
  source 'ora_profile.erb'
  owner 'oracle'
  group 'dba'
end

cookbook_file '/etc/security/limits.d/oracle.conf' do
  mode '0644'
  source 'ora_limits'
end
