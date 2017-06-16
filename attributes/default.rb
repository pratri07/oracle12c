default[:oracle][:user][:uid] = 201
default[:oracle][:user][:gid] = 201
default[:oracle][:user][:shell] = '/bin/ksh'

default[:oracle][:ora_base] = '/opt/oracle'
default[:oracle][:rdbms][:ora_home] = "#{node[:oracle][:ora_base]}/12R1"

default[:oracle][:rdbms][:deps_12c] = ['binutils', 'compat-libcap1', 'compat-libstdc++-33', 'gcc', 'gcc-c++', 'glibc',
                                   'glibc-devel', 'ksh', 'libgcc', 'libstdc++', 'libstdc++-devel', 'libaio',
                                   'libaio-devel', 'libXext', 'libXtst', 'libX11', 'libXau', 'libxcb', 'libXi', 'make', 'sysstat']

default[:oracle][:ora_inventory] = '/opt/oraInventory'

## Settings specific to the Oracle RDBMS proper.
default[:oracle][:rdbms][:ora_home_12c] = "#{node[:oracle][:ora_base]}/12R1"
default[:oracle][:rdbms][:install_dir] = "#{node[:oracle][:ora_base]}/install_dir"

default[:oracle][:rdbms][:install_files] = ['http://10.0.0.231/orasoft/linuxamd64_12102_database_1of2.zip','http://10.0.0.231/orasoft/linuxamd64_12102_database_2of2.zip']

default[:oracle][:curl_options] = "-kO"

default[:oracle][:rdbms][:env_12c] = {'ORACLE_BASE' => node[:oracle][:ora_base],
                                  'ORACLE_HOME' => node[:oracle][:rdbms][:ora_home_12c],
                                  'PATH' => "/usr/kerberos/bin:/usr/local/bin:/bin:/usr/bin:/usr/sbin:#{node[:oracle][:ora_base]}/dba/bin:#{node[:oracle][:rdbms][:ora_home_12c]}/bin:#{node[:oracle][:rdbms][:ora_home_12c]}/OPatch"}
