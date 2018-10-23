require 'spec_helper'

describe package('rsync') do
  it { should be_installed }
end

describe file('/etc/rsyncd.conf') do
  it { should exist }
  it { should be_file }
end
