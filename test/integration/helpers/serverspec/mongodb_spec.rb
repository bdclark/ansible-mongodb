require 'serverspec'

set :backend, :exec

shared_examples_for 'mongodb' do
  describe service('mongod') do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(27_017) do
    it { should be_listening.with('tcp') }
  end

  describe file('/etc/mongod.conf') do
    it { should be_file }
    it { should be_mode 644 }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
  end

  describe file('/etc/logrotate.d/mongod') do
    it { should be_file }
    it { should be_mode 644 }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
  end
end