require 'spec_helper'

describe file('/etc/cloud/cloud.cfg') do
  it { should_not match(/^manage_etc_hosts: (yes|on|true)/) }
end
