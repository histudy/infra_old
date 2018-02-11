require 'spec_helper'

describe package('mackerel-agent-plugins') do
  it { should_not be_installed }
end
describe package('mackerel-check-plugins') do
  it { should_not be_installed }
end

describe file('/etc/mackerel-agent/mackerel-agent.conf') do
  it { should contain 'apikey = "' + ENV['MACKEREL_API_KEY'] + '"' }
end

describe service('mackerel-agent') do
  it { should be_enabled }
  it { should be_running }
end
