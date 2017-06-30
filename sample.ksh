rm -rf /u01/orainv/logs
cd /u01/oracle/install_dir/stage/database 
export DISTRIB=`pwd`
./runInstaller -silent \
   -responseFile $DISTRIB/response/db_install.rsp      \
   oracle.install.option=INSTALL_DB_SWONLY             \
   UNIX_GROUP_NAME=dba                                 \
   INVENTORY_LOCATION=/u01/orainv                      \
   SELECTED_LANGUAGES=en                               \
   ORACLE_HOME=/u01/db12201                            \
   ORACLE_BASE=/u01/oracle                             \
   oracle.install.db.InstallEdition=EE                 \
   oracle.install.db.isCustomInstall=false             \
   oracle.install.db.OSDBA_GROUP=dba                   \
   oracle.install.db.OSBACKUPDBA_GROUP=dba             \
   oracle.install.db.OSDGDBA_GROUP=dba                 \
   oracle.install.db.OSKMDBA_GROUP=dba                 \
   oracle.install.db.OSRACDBA_GROUP=dba                \
   SECURITY_UPDATES_VIA_MYORACLESUPPORT=false          \
   DECLINE_SECURITY_UPDATES=true
