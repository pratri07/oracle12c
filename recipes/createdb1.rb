db = node[:oracle][:rdbms][:dbs]

directory node[:oracle][:rdbms][:dbs_root] do
  owner 'oracle'
  group 'dba'
  mode '0755'
end

dbdir = "#{node[:oracle][:rdbms][:dbs_root]}/#{db}"

directory dbdir do
  owner 'oracle'
  group 'dba'
  mode '0755'
end

template "#{node[:oracle][:rdbms][:ora_home]}/dbs/init#{db}.ora" do
  source 'dbinit.erb'
  owner 'oracle'
  group 'dba'
  mode '0644'
end

template "#{node[:oracle][:rdbms][:ora_home]}/dbs/crdb.sql" do
  source 'crdb.sql.erb'
  owner 'oracle'
  group 'dba'
  mode '0644'
end

bash "dbca_createdb_#{db}" do
  user "oracle"
  group "dba"
  environment (node[:oracle][:rdbms][:env_12c])
  cwd "#{node[:oracle][:rdbms][:ora_home]}/dbs"
  code <<-EOH
    export ORACLE_SID="#{db}"
    echo $ORACLE_SID
    type sqlplus
    "#{node[:oracle][:rdbms][:ora_home]}/bin"/sqlplus / as sysdba @crdb.sql
  EOH
  not_if { File.exist?("#{node[:oracle][:rdbms][:ora_home]}/dbs/hc_#{db}.dat") }
end

#bash 'run_rdbms_installer' do
#    cwd "#{node[:oracle][:rdbms][:ora_home]}/dbs"
#    environment (node[:oracle][:rdbms][:env_12c])
#    code "sudo -Eu oracle #{node[:oracle][:rdbms][:ora_home]}/bin/sqlplus / as sysdba @crdb.sql"
#end

#execute "DBCA_createdb_#{db}" do
#  user 'oracle'
#  group 'dba'
#  environment (node[:oracle][:rdbms][:env_12c])
#  command <<-COMMAND
#    echo "test"
#    export ORACLE_SID="#{db}"
#    echo $ORACLE_SID
#    type sqlplus
#    sqlplus / as sysdba @"#{node[:oracle][:rdbms][:ora_home]}/dbs/crdb.sql"
#  COMMAND
#  action :run
#end
