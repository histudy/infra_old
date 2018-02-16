require 'spec_helper'

describe file('/usr/local/bin/sshfilter') do
  it { should exist }
  it { should be_file }
  it { should be_executable }
  it { should be_mode 755 }
  it { should contain 'ALLOW_COUNTRIES="JP"' }
end

describe file('/usr/local/bin/update_geoip_database') do
  it { should exist }
  it { should be_file }
  it { should be_executable }
  it { should be_mode 755 }
end
