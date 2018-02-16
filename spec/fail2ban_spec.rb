require 'spec_helper'

describe package('fail2ban') do
  it { should be_installed }
end

describe file('/etc/fail2ban/fail2ban.conf') do
  it { should exist }
  it { should be_file }
  it { should contain 'logtarget = /var/log/fail2ban.log' }
end

describe file('/etc/fail2ban/jail.d/local.conf') do
  it { should exist }
  it { should be_file }
  it { should contain 'banaction = firewallcmd-ipset' }
  it { should contain 'backend = systemd' }
  it { should contain('enabled = True').after(/^\[sshd\]/) }
end

describe service('fail2ban') do
  it { should be_enabled }
  it { should be_running }
end
