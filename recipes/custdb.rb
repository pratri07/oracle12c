dbt = data_bag_item('oradb', 'test')
dbca = dbt["node['fqdn']"]['dbs']

oradbca 'create database' do
  db "#{dbca}"
  action :create
end
