oracle_install_flag_file = "#{Chef::Config[:file_cache_path]}/oracle_install_flag_file"

[node[:oracle][:ora_base_fs], node[:oracle][:ora_base], node[:oracle][:rdbms][:ora_home], node[:oracle][:rdbms][:install_dir]].each do |dir|
  directory dir do
    owner 'oracle'
    group 'dba'
    mode '0775'
    action :create
  end
end

yum_package 'unzip'

remote_file '/u01/oracle/install_dir/linuxx64_12201_database.zip' do
  source 'http://10.0.0.231/orasoft/linuxx64_12201_database.zip'
  owner 'oracle'
  group 'dba'
  action :create
end

#node[:oracle][:rdbms][:install_files].each do |zip_file|
#  execute "fetch_oracle_media" do
#    command "curl #{node[:oracle][:curl_options]} #{zip_file}"
#    user 'oracle'
#    group 'dba'
#    cwd node[:oracle][:rdbms][:install_dir]
#  end

  execute "unzip_oracle_media" do
    command "unzip linuxx64_12201_database.zip"
    user 'oracle'
    group 'dba'
    cwd node[:oracle][:rdbms][:install_dir]
    not_if { File.exist?('/u01/oracle/install_dir/database/runInstaller') }
  end

#end

file "#{node[:oracle][:ora_base]}/oraInst.loc" do
   owner "oracle"
   group 'dba'
   content "inst_group=dba\ninventory_loc=/u01/orainv"
end

directory node[:oracle][:ora_inventory] do
   owner 'oracle'
   group 'dba'
   mode '0775'
   action :create
end

template "#{node[:oracle][:ora_base_fs]}/db12c.rsp" do
  owner 'oracle'
  group 'dba'
  mode '0775'
end

bash 'run_rdbms_installer' do
    cwd "/u01/oracle/install_dir/database"
    environment (node[:oracle][:rdbms][:env_12c])
    code "sudo -Eu oracle ./runInstaller -showProgress -waitforcompletion -silent -noconfig -debug -force -responseFile /u01/db12c.rsp"
    returns [0, 6]
    not_if { File.exist?('/u01/db12201/bin/sqlplus') }
end

execute 'root.sh_rdbms' do
    command <<-COMMAND
      #{node[:oracle][:rdbms][:ora_home_12c]}/root.sh
      #{node[:oracle][:ora_inventory]}/orainstRoot.sh
      touch #{oracle_install_flag_file}
    COMMAND
    not_if { File.exist?(oracle_install_flag_file) }
end
