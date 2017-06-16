bash 'sysctl_reload' do
  code 'source /etc/init.d/functions && apply_sysctl'
  action :nothing
end

directory '/etc/sysctl.d' do
  mode '0755'
end

cookbook_file '/etc/sysctl.d/ora_params' do
  mode '0644'
  notifies :run, 'bash[sysctl_reload]', :immediately
end
