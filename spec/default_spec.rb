require 'spec_helper'

describe package('dehydrated') do
  it { should be_installed }
end

describe file('/etc/dehydrated/conf.d/localhost.sh') do
  it { should exist }
  it { should be_file }
end

describe file('/etc/dehydrated/domains.txt') do
  it { should exist }
  it { should be_file }
end

describe file('/etc/cron.d/ansible_management_job') do
  it { should contain '/usr/bin/dehydrated --cron' }
end

describe file('/etc/dehydrated/hook.sh') do
  it { should exist }
  it { should be_file }
  it { should be_executable }
end
