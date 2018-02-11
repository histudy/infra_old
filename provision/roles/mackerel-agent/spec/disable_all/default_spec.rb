require 'spec_helper'

describe package('mackerel-agent-plugins') do
  it { should_not be_installed }
end
describe package('mackerel-check-plugins') do
  it { should_not be_installed }
end

describe file('/etc/mackerel-agent/mackerel-agent.conf') do
  it { should contain 'apikey = "disable_all_api_key"' }
end

describe service('mackerel-agent') do
  it { should_not be_enabled }
  it { should_not be_running }
end
