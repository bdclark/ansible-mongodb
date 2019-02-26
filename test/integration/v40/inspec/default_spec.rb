describe package('mongodb-org') do
  it { should be_installed }
  its('version') { should match /^4.0.5/ }
end
