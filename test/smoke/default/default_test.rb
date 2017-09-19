# # encoding: utf-8

# Inspec test for recipe oraaudit::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe port(1521) do
  it { should_not be_listening }
end

describe user('oracle') do
  it { should exist }
  its('uid') { should eq 201 }
  its('shell') { should eq '/bin/ksh' }
end

describe file('/u01/orainv') do
    it { should be_directory }
    it { should be_owned_by 'oracle' }
end

describe kernel_parameter('kernel.shmmax') do
  its('value') { should eq 4294967295 }
end

describe grub_conf('/etc/grub.conf',  'default') do
  its('kernel') { should include 'transparent_hugepage=never' }
end

describe file('/etc/grub_conf') do
  its('content') { should match /transparent_hugepage=never/ }
end

describe bash('ls -al /u01/db12201/bin') do
  its('stdout') { should match /sqlplus/ }
  its('exit_status') { should eq 0 }
end
