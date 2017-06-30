default[:oracle][:user][:uid] = 201
default[:oracle][:user][:gid] = 201
default[:oracle][:user][:shell] = '/bin/ksh'

default[:oracle][:ora_base_fs] = '/u01'
default[:oracle][:ora_base] = "#{node[:oracle][:ora_base_fs]}/oracle"
default[:oracle][:rdbms][:ora_home] = "#{node[:oracle][:ora_base_fs]}/db12201"

default[:oracle][:rdbms][:deps_12c] = ['binutils.x86_64', 'compat-libcap1.x86_64', 'gcc.x86_64', 'gcc-c++.x86_64', 'glibc.i686', 'glibc.x86_64',
'glibc-devel.i686', 'glibc-devel.x86_64', 'ksh', 'compat-libstdc++-33', 'libaio.i686', 'libaio.x86_64', 'libaio-devel.i686', 'libaio-devel.x86_64',
'libgcc.i686', 'libgcc.x86_64', 'libstdc++.i686', 'libstdc++.x86_64', 'libstdc++-devel.i686', 'libstdc++-devel.x86_64', 'libXi.i686', 'libXi.x86_64',
'libXtst.i686', 'libXtst.x86_64', 'make.x86_64', 'sysstat.x86_64']

default[:oracle][:ora_inventory] = '/u01/orainv'

## Settings specific to the Oracle RDBMS proper.
default[:oracle][:rdbms][:ora_home_12c] = "/u01/db12201"
default[:oracle][:rdbms][:install_dir] = "#{node[:oracle][:ora_base]}/install_dir"

default[:oracle][:rdbms][:install_files] = ['https://10.0.0.231/orasoft/linuxamd64_12102_database_1of2.zip','https://10.0.0.231/orasoft/linuxamd64_12102_database_2of2.zip']

default[:oracle][:curl_options] = "-kO"

default[:oracle][:rdbms][:env_12c] = {'ORACLE_BASE' => node[:oracle][:ora_base],
                                  'ORACLE_HOME' => node[:oracle][:rdbms][:ora_home_12c],
                                  'PATH' => "/usr/kerberos/bin:/usr/local/bin:/bin:/usr/bin:/usr/sbin:#{node[:oracle][:rdbms][:ora_home_12c]}/bin:#{node[:oracle][:rdbms][:ora_home_12c]}/OPatch"}

default[:oracle][:rdbms][:sys_pw] = 'Temp#12345'
default[:oracle][:rdbms][:system_pw] = 'Temp#dddd2222'
default[:oracle][:rdbms][:dbsnmp_pw] = 'Change#43RRR2212'

default[:oracle][:rdbms][:db_create_template] = 'default_template.dbt'

default[:oracle][:rdbms][:dbs] = 'voltdb'

default[:oracle][:rdbms][:dbs_root] = "/oradata"
