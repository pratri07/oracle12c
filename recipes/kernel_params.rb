execute 'sysctl_reload' do
  command <<-COMMAND
    source /etc/init.d/functions
    apply_sysctl
  COMMAND
  action :nothing
end

directory '/etc/sysctl.d' do
  mode '0755'
end

cookbook_file '/etc/sysctl.d/ora_params' do
  mode '0644'
  notifies :run, 'execute[sysctl_reload]', :immediately
end
