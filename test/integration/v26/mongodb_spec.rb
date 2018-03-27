describe package('mongodb-org') do
  it { should be_installed }
  its('version') { should match /^2.6/ }
end

describe service('mongod') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe port(27_017) do
  it { should be_listening }
  its('addresses') { should include '0.0.0.0' }
end