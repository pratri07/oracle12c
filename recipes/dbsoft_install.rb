[node[:oracle][:ora_base], node[:oracle][:rdbms][:install_dir]].each do |dir|
  directory dir do
    owner 'oracle'
    group 'dba'
    mode '0755'
    action :create
  end
end

yum_package 'unzip'

node[:oracle][:rdbms][:install_files].each do |zip_file|
  execute "fetch_oracle_media" do
    command "curl #{node[:oracle][:curl_options]} #{zip_file}"
    user 'oracle'
    group 'dba'
    cwd node[:oracle][:rdbms][:install_dir]
  end

  execute "unzip_oracle_media" do
    command "unzip #{File.basename(zip_file)}"
    user 'oracle'
    group 'dba'
    cwd node[:oracle][:rdbms][:install_dir]
  end
end

file "#{node[:oracle][:ora_base]}/oraInst.loc" do
   owner "oracle"
   group 'dba'
   content "inst_group=dba\ninventory_loc=/opt/oraInventory"
end

directory node[:oracle][:ora_inventory] do
   owner 'oracle'
   group 'dba'
   mode '0755'
   action :create
end

template "#{node[:oracle][:rdbms][:install_dir]}/db12c.rsp" do
  owner 'oracle'
  group 'dba'
  mode '0644'
end  

bash 'run_rdbms_installer' do
    cwd "#{node[:oracle][:rdbms][:install_dir]}/database"
    environment (node[:oracle][:rdbms][:env_12c])
    code "sudo -Eu oracle ./runInstaller -showProgress -silent -waitforcompletion -ignoreSysPrereqs -responseFile #{node[:oracle][:rdbms][:install_dir]}/db12c.rsp -invPtrLoc #{node[:oracle][:ora_base]}/oraInst.loc"
    returns [0, 6]
  end
 
  execute 'root.sh_rdbms' do
    command "#{node[:oracle][:rdbms][:ora_home_12c]}/root.sh"
  end

