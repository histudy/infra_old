require 'spec_helper'

%w[ufw etckeeper mackerel-agent].each do |name|
  describe package(name) do
    it { should be_installed }
  end
end

%w[ufw mackerel-agent].each do |name|
  describe service(name) do
    it { should be_enabled }
    it { should be_running }
  end
end

describe command('ufw status verbose') do
  its(:stdout) { should match(/Status: active/) }
  its(:stdout) { should match(/Logging: on/) }
  its(:stdout) { should match(/Default: deny/) }
end
