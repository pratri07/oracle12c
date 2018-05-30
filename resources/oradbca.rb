resource_name :oradbca

property :db, String, required: true

action :create do
  directory node[:oracle][:rdbms][:dbs_root] do
    owner 'oracle'
    group 'dba'
    mode '0755'
  end

  dbdir = "#{node[:oracle][:rdbms][:dbs_root]}/#{new_resource.db}"

  directory dbdir do
    owner 'oracle'
    group 'dba'
    mode '0755'
  end

  template "#{node[:oracle][:rdbms][:ora_home]}/dbs/init#{new_resource.db}.ora" do
    source 'dbinit.erb'
    owner 'oracle'
    group 'dba'
    mode '0644'
    variables(db_name: new_resource.db)
  end

  template "#{node[:oracle][:rdbms][:ora_home]}/dbs/crdb.sql" do
    source 'crdb.sql.erb'
    owner 'oracle'
    group 'dba'
    mode '0644'
    variables(db_name: new_resource.db)
  end

  bash "dbca_createdb_#{new_resource.db}" do
    user "oracle"
    group "dba"
    environment (node[:oracle][:rdbms][:env_12c])
    cwd "#{node[:oracle][:rdbms][:ora_home]}/dbs"
    code <<-EOH
      export ORACLE_SID="#{new_resource.db}"
      echo $ORACLE_SID
      type sqlplus
      "#{node[:oracle][:rdbms][:ora_home]}/bin"/sqlplus / as sysdba @crdb.sql
    EOH
    not_if { ::File.exist?("#{node[:oracle][:rdbms][:ora_home]}/dbs/hc_#{new_resource.db}.dat") }
  end
end
