require 'spec_helper'

describe file('/usr/local/bin/sshfilter') do
  it { should exist }
  it { should be_file }
  it { should be_executable }
  it { should be_mode 755 }
  it { should contain "ALLOW_COUNTRIES=\"#{property['common_ssh_allow_countries'].join(' ')}\"" }
end

describe file('/usr/local/bin/update_geoip_database') do
  it { should exist }
  it { should be_file }
  it { should be_executable }
  it { should be_mode 755 }
end

describe file('/etc/hosts.deny') do
  if property['common_ssh_use_geoip_filter']
    its(:content) { should match(/^sshd: ALL/) }
  else
    its(:content) { should_not match(/^sshd:/) }
  end
end

describe file('/etc/hosts.allow') do
  if property['common_ssh_use_geoip_filter']
    its(:content) { should match(/^sshd:/) }
  else
    its(:content) { should_not match(/^sshd:/) }
  end
end

describe file('/etc/cron.d/ansible_management_job') do
  if property['common_ssh_use_geoip_filter']
    it { should contain '/usr/local/bin/update_geoip_database' }
  else
    it { should_not contain '/usr/local/bin/update_geoip_database' }
  end
end
