# # encoding: utf-8

# Inspec test for recipe oraaudit::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

unless os.windows?
  # This is an example test, replace with your own test.
  describe user('root'), :skip do
    it { should exist }
  end
end

# This is an example test, replace it with your own test.
describe port(80), :skip do
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
