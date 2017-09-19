sql = oracledb_session( user: 'system', pass: 'Temp#dddd2222', host: 'chefd.local.com', service: 'chkdb', sqlplus_bin: '/u01/db12201/bin/sqlplus' )
describe sql.query('SELECT NAME FROM v$database;').row(0).column('NAME') do
  its('value') { should cmp 'CHKDB' }
end

#describe command('sudo -i -u oracle sqlplus system/Temp#dddd2222@chkdb') do
#   its('stderr') { should eq '' }
#end

#describe bash('sudo -i -u oracle /u01/db12201/bin/sqlplus system/Temp#dddd2222@chkdb') do
#  its('stdout') { should match /SQL*Plus/ }
#  its('stderr') { should eq '' }
#end
