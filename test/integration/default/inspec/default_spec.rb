if os.debian?
  mongodb_user = 'mongodb'
  mongodb_group = 'mongodb'
  data_dir = '/var/lib/mongodb'
elsif os.redhat?
  mongodb_user = 'mongod'
  mongodb_group = 'mongod'
  data_dir = '/var/lib/mongo'
end

describe package('mongodb-org') do
  it { should be_installed }
end

describe service('mongod') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe port(27_017) do
  it { should be_listening }
  its('addresses') { should include '127.0.0.1' }
end

describe file('/etc/mongod.conf') do
  it { should be_file }
  it { should be_owned_by 'root' }
  its('mode') { should cmp '0644' }
end

describe yaml('/etc/mongod.conf') do
  its(%w[storage dbPath]) { should eq data_dir }
  its(%w[storage journal enabled]) { should eq true }
  its(%w[systemLog destination]) { should eq 'file' }
  its(%w[systemLog logAppend]) { should eq true }
  its(%w[systemLog path]) { should eq '/var/log/mongodb/mongod.log' }
end

describe directory(data_dir) do
  it { should be_owned_by mongodb_user }
  it { should be_grouped_into mongodb_group }
  its('mode') { should cmp '0755' }
end

describe directory('/var/log/mongodb') do
  it { should be_owned_by mongodb_user }
  it { should be_grouped_into mongodb_group }
  its('mode') { should cmp '0755' }
end

describe file('/etc/logrotate.d/mongod') do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  its('mode') { should cmp '0644' }
end

describe file('/etc/logrotate.d/mongod') do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  its('mode') { should cmp '0644' }
end

describe file('/etc/mongodb.keyfile') do
  it { should be_file }
  it { should be_owned_by mongodb_user }
  it { should be_grouped_into mongodb_group }
  it { should be_readable.by('owner') }
  its('mode') { should cmp '0600' }
  its('content') { should eq 'ilikerandomsecrets' }
end

describe directory('/etc/systemd/system/disable-thp.service') do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  its('mode') { should cmp '0644' }
  its('content') { should match(/^\[Unit\]$/) }
end
