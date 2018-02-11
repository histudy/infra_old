require 'spec_helper'

property['common_groups'].each do |group|
  describe group(group['name']) do
    if group.key?('remove') && group['remove']
      it { should_not exist }
    else
      it { should exist }
    end
  end
end

property['common_users'].each do |user|
  describe user(user['name']) do
    if user.key?('remove') && user['remove']
      it { should_not exist }
    else
      it { should exist }
      it { should belong_to_group 'adm' } if user.key?('admin') && user['admin']
      if user.key?('groups')
        user['groups'].each do |group|
          it { should belong_to_group group }
        end
      end
    end
  end
end

property['common_packages'].each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end

describe package('ufw') do
  it { should be_installed }
end

describe package('etckeeper') do
  it { should be_installed }
end

describe package('fail2ban') do
  it { should be_installed }
end

describe file('/etc/fail2ban/jail.d/local.conf') do
  it { should exist }
  it { should be_file }
end

describe service('ufw') do
  it { should be_enabled }
  it { should be_running }
end
describe service('fail2ban') do
  it { should be_enabled }
  it { should be_running }
end
