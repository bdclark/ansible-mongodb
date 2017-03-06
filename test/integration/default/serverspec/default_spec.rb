require 'mongodb_spec'

describe 'mongodb' do
  it_behaves_like 'mongodb'
end

describe command(%(mongo --quiet --eval 'db.version()' admin)) do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match(/^3.2/) }
end
