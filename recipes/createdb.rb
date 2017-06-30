db = node[:oracle][:rdbms][:dbs]

directory node[:oracle][:rdbms][:dbs_root] do
  owner 'oracle'
  group 'dba'
  mode '0755'
end

template "#{node[:oracle][:rdbms][:ora_home]}/assistants/dbca/templates/default_template.dbt" do
  owner 'oracle'
  group 'dba'
  mode '0644'
end

bash "dbca_createdb_#{db}" do
      user "oracle"
      group "dba"
      environment (node[:oracle][:rdbms][:env_12c])
      code "dbca -silent -createDatabase -emConfiguration DBEXPRESS -templateName #{node[:oracle][:rdbms][:db_create_template]} -gdbname #{db} -sid #{db} -sysPassword #{node[:oracle][:rdbms][:sys_pw]} -systemPassword #{node[:oracle][:rdbms][:system_pw]}"
    end


