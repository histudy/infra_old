require 'spec_helper'

property['common_packages'].each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end

%w[python-apt aptitude].each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end

describe package('etckeeper') do
  it { should be_installed }
end

describe file('/etc/fail2ban/jail.d/local.conf') do
  it { should exist }
  it { should be_file }
end
