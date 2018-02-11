require 'spec_helper'

describe file('/etc/apt/sources.list.d/mackerel.list') do
  it { should exist }
  it { should be_file }
  it { should contain 'deb http://apt.mackerel.io/v2/ mackerel contrib' }
end

describe package('mackerel-agent') do
  it { should be_installed }
end

describe file('/etc/mackerel-agent/mackerel-agent.conf') do
  it { should exist }
  it { should be_file }
end
