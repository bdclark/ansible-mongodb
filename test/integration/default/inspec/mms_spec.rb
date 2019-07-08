mongodb_user = os.debian? ? 'mongodb' : 'mongod'

describe package('mongodb-mms-automation-agent-manager') do
  it { should be_installed }
end

describe service('mongodb-mms-automation-agent') do
  it { should be_installed }
  it { should be_enabled }
end

describe file('/etc/mongodb-mms/automation-agent.config') do
  it { should be_file }
  it { should be_owned_by mongodb_user }
  it { should be_grouped_into mongodb_user }
  its('mode') { should cmp '0600' }
  its('content') { should match(/^mmsGroupId=my_automation_agent_group_id$/) }
  its('content') { should match(/^mmsApiKey=my_automation_agent_api_key$/) }
end

describe package('mongodb-mms-monitoring-agent') do
  it { should be_installed }
end

describe service('mongodb-mms-monitoring-agent') do
  it { should be_installed }
  it { should be_enabled }
end

describe file('/etc/mongodb-mms/monitoring-agent.config') do
  it { should be_file }
  it { should be_owned_by 'mongodb-mms-agent' }
  it { should be_grouped_into 'mongodb-mms-agent' }
  its('mode') { should cmp '0600' }
  its('content') { should match(/^mmsGroupId=my_monitor_agent_group_id$/) }
  its('content') { should match(/^mmsApiKey=my_monitor_agent_api_key$/) }
end
